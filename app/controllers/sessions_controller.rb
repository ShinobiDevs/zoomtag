class SessionsController < Devise::SessionsController
  before_filter :authenticate_player!, :except => [:create, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:create]
  respond_to :json

  def create
    resource = Player.find_for_database_authentication(:facebook_access_token => params[:access_token], facebook_uuid: params[:uuid])
    
    if resource.blank?
      facebook_user = FbGraph::User.fetch(params[:uuid])

      email = facebook_user.email || "#{params[:uuid]}@zoomtag.com"
      resource = Player.create!(facebook_access_token: params[:access_token],
                                facebook_uuid: params[:uuid],
                                password: Devise.friendly_token[0,20],
                                email: email)
    end

    sign_in(:player, resource)
    resource.ensure_authentication_token!
    render :json=> {:auth_token=>resource.authentication_token, :access_token => resource.facebook_access_token}
    return
  end

  def destroy
    resource = Player.find_for_database_authentication(:facebook_access_token => params[:access_token])
    resource.authentication_token = nil
    resource.save
    render nothing: true, status: :ok
  end

  protected

  def invalid_login_attempt
    render :json=> {:message=>"Error with your login or password"}, :status=> :unauthorized
  end
end