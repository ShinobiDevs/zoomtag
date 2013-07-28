class GamesController < ApplicationController
  
  before_filter :authenticate_player!
  respond_to :json

  # GET /games.json
  def index
    respond_with(current_player.games)
  end

  # POST /games.json
  def create
    @game = current_player.games.build(params.require(:game).permit(:player2_id))
    @game.player1 = current_player
    @game.current_turn = current_player.id
    @game.started_by_player_id = current_player.id
    @game.save
    respond_with(@game)
  end

  # GET /games/1.json
  def show
    @game = current_player.games.find(params[:id])
    respond_with(@game)
  end
end
