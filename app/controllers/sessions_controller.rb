class SessionsController < ApplicationController
  def show
    @auth = request.env['omniauth.auth']
    apikey = "#{@auth['credentials']['token']}-#{@auth['extra']['metadata']['dc']}"
    u = User.find_or_create_by_user_id(@auth['info']['uid'])
    u.update_attributes(apikey: apikey, username: @auth['extra']['raw_info']['username'])
    session[:user] = u.id
    redirect_to root_url
  end
  def destroy
    reset_session
    redirect_to root_url
  end

end
