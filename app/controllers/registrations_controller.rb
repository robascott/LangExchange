class RegistrationsController < Devise::RegistrationsController
	protected

	  def after_sign_up_path_for(resource)
	  	current_user_id = current_user.id
	    "/users/#{current_user_id}/preferences" # Or :prefix_to_your_route
	  end

	  def after_inactive_sign_up_path_for(resource)
	    current_user_id = current_user.id
	   	"/users/#{current_user_id}/preferences"
	  end
end