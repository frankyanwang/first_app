class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to "/401.html"
  end
end
