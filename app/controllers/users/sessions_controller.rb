class Users::SessionsController < Devise::SessionsController
  # Utilisation du username pour l'authentification
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  protected

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end
