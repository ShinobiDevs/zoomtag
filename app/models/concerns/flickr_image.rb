class FlickrImage

  include ActiveModel::Model

  attr_accessor :id, :owner, :secret, :server, :farm, :title, :ispublic, :isfriend, :isfamily, :original_resp

  def FlickrImage.search(options = {})
    photos = flickr.photos.search(options)
    photos.to_a.collect {|p| FlickrImage.new(p.to_hash.merge(original_resp: p)).url }
  end

  def url
    FlickRaw.url_s(self.original_resp)
  end
end