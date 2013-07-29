class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :something_not_found
  rescue_from FbGraph::InvalidToken, with: :invalid_fb_token

  def invalid_fb_token
    render json: {error: "invalid facebook token"}, status: :unauthorized
  end

  def something_not_found
    render json: {error: "not found", code: 404}, status: :not_found
    return
  end
end
