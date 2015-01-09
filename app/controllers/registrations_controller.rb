class RegistrationsController < Devise::RegistrationsController

  def update_resource(resource, params)
    if current_user.provider == "github"
      params.delete(:current_password)
      resource.update_without_password(account_update_params)
    else
      resource.update_with_password(account_update_params)
    end
  end

  private
 
  def sign_up_params
    params.require(:user).permit(:name, :password, :email, :password_confirmation)
  end
 
  def account_update_params
    params.require(:user).permit(:password, :email, :password_confirmation, :current_password, :remove_avatar, :avatar)
  end
end