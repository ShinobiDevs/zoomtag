class PicturesController < ApplicationController
  before_filter :authenticate_player!
  respond_to :json

  def index
    photo_urls = FlickrImage.search(params)
    respond_with(photo_urls)
  end
end
