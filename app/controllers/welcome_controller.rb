class WelcomeController < ApplicationController

  def index
    @user = current_user
    @url = Url.new
    @urls = current_user.urls.order("id ASC")
  end

end
