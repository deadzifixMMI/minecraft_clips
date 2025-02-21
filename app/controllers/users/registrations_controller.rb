class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Permet d'ajouter le username et l'email
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username email])
  end
end
