class RegistrationsController < Devise::RegistrationsController

  private
 
  def sign_up_params
  	puts "SIGN UP PARAMS"
  	puts params
    params.require(:user).permit(:name, :password, :email, :password_confirmation)
  end
 
  def account_update_params
  	puts "ACCOUNT UPDATE PARAMS"
  	puts params
    params.require(:user).permit(:password, :email, :password_confirmation, :current_password, :remove_avatar)
  end
end