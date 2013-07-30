class AnswersController < ApplicationController
  before_filter :authenticate_player!, :find_game
  respond_to :json

  # POST /games/1/answers.json
  def create
    @challenge = @game.challanges.find(params[:id])
    answer = params[:answer]
    difficulty = params[:difficulty]

    if @challenge.answer(difficulty.downcase) == answer.downcase
      @challenge.update_attribute(:guessed_by_id, current_player.id)
      fb_user = current_player.to_fb
      fb_user.og_action!("zoomtag:guess", 
                                      zoomtag: "http://zoomtag.heroku.com/challanges_actions/#{@challenge.id}?difficulty=#{difficulty.downcase}",
                                      guessed_word: @challenge.answer(difficulty.downcase),
                                      difficulty: difficulty.downcase,
                                      explicitly_shared: 1,
                                      guess_image_url: @challenge.image_url,
                                      access_token: FACEBOOK_APP.access_token)
      @game.score!(current_player, difficulty.downcase)
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
