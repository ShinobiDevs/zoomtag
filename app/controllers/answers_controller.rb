class AnswersController < ApplicationController
  before_filter :authenticate_player!, :find_game
  respond_to :json

  # POST /games/1/answers.json
  def create
    @challenge = @game.challanges.find(params[:id])
    answer = params[:answer]
    difficulty = params[:difficulty]
    case difficulty.downcase
    when "easy"
      @success = @challenge.easy_tag == answer.downcase
    when "medium"
      @success = @challenge.medium_tag == answer.downcase
    when "hard"
      @success = @challenge.medium_tag == answer.downcase
    else
      render json: {error: "#{difficulty} is an invalid difficulty"}, status: :unprocessable_entity
      return
    end

    if @success
      render nothing: true, status: :ok
    else
      render nothing: true, status: :conflict
    end
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
