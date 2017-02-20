class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end


  def is_administratior?
	  	if user_signed_in? # if user signed
	   		if !current_user.admin? # if adminstrator return true
	    		redirect_to root_path
	   		end
	  	else
	    	redirect_to login_path
	    end
	end
end
