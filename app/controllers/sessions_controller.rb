class SessionsController < Devise::SessionsController  
  # overwrite devise session controller to have API call.   
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
  
    respond_to do |format|
      format.html do
        respond_with resource, :location => redirect_location(resource_name, resource)
      end
      format.json do
        render :json => { :response => 'ok', :auth_token => current_user.authentication_token, :logged => true }.to_json, :status => :ok
      end
    end
  end
  
  
  # def create  
  #   respond_to do |format|  
  #     format.html { super }  
  #     format.json {  
  #       puts "create block json"
  #       warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")  
  #       puts "render json return"
  #       render :status => 200, :json => { :error => "Success" }  
  #       #render :json => { :response => 'ok', :auth_token => current_user.authentication_token }.to_json, :status => :ok
  #     }  
  #   end  
  # end
  
  # def destroy
  #   super
  #   reset_session
  # end
  
     
end