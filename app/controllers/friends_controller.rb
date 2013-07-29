class FriendsController < ApplicationController
  before_filter :authenticate_player!
  respond_to :json

  # GET /players/1/friends.json
  def index
    facebook_me = FbGraph::User.fetch(current_player.facebook_uuid, access_token: FACEBOOK_APP.access_token)
    currently_playing_with_uuids = current_player.playing_with_players
    friends_in_app_uuids = facebook_me.friends(:fields => "installed").collect(&:identifier)
    friends_uuids = friends_in_app_uuids - currently_playing_with_uuids
    @players = Player.where(facebook_uuid: friends_uuids).all
    respond_with(current_player, @players)
  end
end
