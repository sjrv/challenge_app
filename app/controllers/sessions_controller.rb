class SessionsController < ApplicationController
  def create
    @user = User.find_by_github_uid(omniauth["uid"]) || User.create_from_omniauth(omniauth)
    self.current_user = @user
    redirect_to user_omniauth_callback_path(:github)
  end

  protected

  def omniauth
    request.env['omniauth.auth']
  end
end
