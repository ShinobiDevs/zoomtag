class GamesController < ApplicationController
  before_filter :authenticate_player!

  respond_to :json

  # GET /games.json
  def index
    respond_with({games: current_player.games})
  end

  # GET /games/1.json
  def show
    @game = current_player.games.find(params[:id])
    respond_with(@game)
  end
end
