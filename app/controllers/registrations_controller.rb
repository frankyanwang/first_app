class RegistrationsController < Devise::RegistrationsController  
  
  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)

        respond_to do |format|
          format.html do
            respond_with resource, :location => after_sign_up_path_for(resource)
          end
          format.json do
            render :json => { :response => 'ok', :auth_token => current_user.authentication_token, :logged => true }.to_json, :status => :ok
          end
        end        
      else
        set_flash_message :notice, :inactive_signed_up, :reason => inactive_reason(resource) if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    end    
    
  end
     
end