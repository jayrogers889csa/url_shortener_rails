class UrlsController < ApplicationController

  # def index
  #   redirect_to :index
  # end

  def new
    @url = Url.new
  end

  def create
    @user = current_user
    p url_params
    @url = @user.urls.find_or_create_by(url_params)

    if @url.valid?
      redirect_to root_path
    else
      flash[:notice] = 'Invalid URL'
      redirect_to root_path
    end
  end

  def shorturl
    @url = Url.find_by_shortened(params[:short_ened])
    p "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    p @url
    # @url.click_count += 1
    # @url.save
    # p "here"

    redirect_to @url.original
  end

  private

  def url_params
    params.require(:url).permit(:original)
  end
end
