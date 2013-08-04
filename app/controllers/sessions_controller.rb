class SessionsController < Devise::SessionsController
  before_filter :authenticate_player!, :except => [:create, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:create]
  respond_to :json

  def create
    resource = Player.find_for_database_authentication(facebook_access_token: params[:access_token])
    
    if resource.blank?
      facebook_user = FbGraph::User.fetch :me, access_token: params[:access_token]

      email = facebook_user.email || "guest_#{facebook_user.identifier}@zoomtag.com"
      resource = Player.create!(facebook_access_token: facebook_user.access_token.to_s,
                                facebook_uuid: facebook_user.identifier,
                                name: facebook_user.name,
                                profile_picture: facebook_user.picture,
                                password: Devise.friendly_token[0,20],
                                email: email)
    end

    sign_in(:player, resource)
    resource.ensure_authentication_token!
    
    render :json => resource
    return
  end

  def destroy
    resource = Player.find_for_database_authentication(facebook_uuid: params[:uuid])
    resource.authentication_token = nil
    resource.save
    render nothing: true, status: :ok
  end

  protected

  def invalid_login_attempt
    render :json=> {:message=>"Error with your login or password"}, :status=> :unauthorized
  end
end