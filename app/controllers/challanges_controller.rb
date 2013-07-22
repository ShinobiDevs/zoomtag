class ChallangesController < ApplicationController

  before_filter :authenticate_player!
  respond_to :json

  # GET /games/1/challanges.json
  def index
    @games = current_player.games.find(params[:game_id]).challanges
    respond_with(@games)
  end

  # GET /games/1/challanges/1.json
  def show
    @challange = current_player.games.find(params[:game_id]).challanges.find(params[:id])
    respond_with(@challange)
  end

  # POST /games.json
  def create
    @challange = current_player.games.find(params[:game_id]).challanges.build(params[:challange])
    @challange.player = current_player
    @challange.save
    respond_with(@challange)
  end
end
