class SessionsController < ApplicationController
  def create
  	binding.pry
  	puts "AUTH HASH".green
    @user = User.find_by_github_uid(omniauth["uid"]) || User.create_from_omniauth(omniauth)
    self.current_user = @user
    redirect_to user_omniauth_callback_path(:github)
  end

  protected

  def omniauth
  	puts "PARAMS".green
  	puts params
    request.env['omniauth.auth']
  end
end
