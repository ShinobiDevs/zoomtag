class ChallangesController < ApplicationController

  before_filter :authenticate_player!, :find_game
  respond_to :json

  # GET /games/1/challanges.json
  def index
    @games = @game.challanges
    respond_with(@games)
  end

  # GET /games/1/challanges/1.json
  def show
    @challange = @game.challanges.find(params[:id])
    respond_with(@challange)
  end

  # POST /games/1/challanges.json
  def create
    @challange = @game.challanges.build(params[:challange])
    @challange.player = current_player
    respond_with(@challange)
  end

  protected

  def find_game
    @game = current_player.games.where(params[:game_id]).includes(:challanges).first
    if @game.blank?
      render nothing: true, status: :not_found
      return
    end
  end
end
