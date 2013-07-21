class GamesController < ApplicationController
  before_filter :authenticate_player!

  def index
    render json: {games: []}
  end
end
