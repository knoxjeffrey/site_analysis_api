class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  respond_to :html, only: []
  respond_to :xml, only: []

  before_filter :not_allowed, only: [:new, :edit, :cancel]

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        output = "An account for #{resource.full_name} has been created".to_json
        render json: output, status: 201
        #respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end


  def not_allowed
    raise MethodNotAllowed
  end

  private

  def sign_up_params
    params.require(:user).permit([
      :email,
      :password,
      :password_confirmation,
      :full_name
    ])
  end

  def account_update_params
    params.require(:user).permit([
      :email,
      :full_name
    ])
  end
end