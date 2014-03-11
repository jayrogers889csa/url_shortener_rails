class Url < ActiveRecord::Base

  belongs_to :user
  before_create :shorten, :validate_url

  def shorten
    if !self.shortened
      self.shortened = SecureRandom.hex(3)
    end
  end

  def validate_url
    if self.original == "" || ! self.original.match(/.+\.\w{2,}/)
      return errors.add(:original, "This is not a valid web address!")
    end
    unless self.original.match(/\Ahttps?:\/\//)
      self.original = "http://".concat(self.original)
    end
    begin
      parsed_uri = URI(self.original)
      rescue
      return errors.add(:original, "This is not a valid web address!")
    end
    response = Net::HTTP.get_response(parsed_uri)
    unless 200 <= response.code.to_i && response.code.to_i < 400 && response.code.to_i != 303
      return errors.add(:original, "This is not a valid web address!")
    end
  end

  def ascending_order
    self.order("id ASC")
  end
end
