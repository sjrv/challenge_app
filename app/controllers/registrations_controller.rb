class RegistrationsController < Devise::RegistrationsController

  private
 
  def sign_up_params
    params.require(:user).permit(:name, :password, :email, :password_confirmation)
  end
 
  def account_update_params
    params.require(:user).permit(:password, :email, :password_confirmation, :current_password, :remove_avatar)
  end
end