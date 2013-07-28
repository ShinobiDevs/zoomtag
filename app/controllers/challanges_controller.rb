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
    respond_with([@game, @challange])
  end

  # POST /games/1/challanges.json
  def create
    @challange = @game.challanges.build(params.require(:challange).permit(:image_url, :easy_tag, :medium_tag, :hard_tag))
    @challange.player = current_player
    @challange.save
    respond_with([@game, @challange])
  end

  protected

  def find_game
    @game = current_player.games.where(params[:game_id]).includes(:challanges).first
    if @game.blank?
      something_not_found
    end
  end
end
