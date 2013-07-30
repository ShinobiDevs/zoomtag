class ChallangesActionsController < ApplicationController
  
  respond_to :html
  
  def show
    @challenge = Challange.find(params[:id])
  end
end
