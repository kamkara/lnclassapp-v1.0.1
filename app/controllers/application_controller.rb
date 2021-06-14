class ApplicationController < ActionController::Base

before_action :store_user_location!, if: :storable_location?
  # as `authenticate_user!` (or whatever your resource is) will halt the filter chain and redirect 
  # before the location can be stored.


private
# - The request is an Ajax request as this can lead to very unexpected behaviour.
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end

    def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:user, request.fullpath)
    end
protected

  def after_sign_in_path_for(resource)
    # return the path based on resource
  end

  
  
#not auto sign out user when their edit pwd
  def update
  if current_user.update_with_password(params[:user_params])
    bypass_sign_in current_user
    redirect_to root_path, notice: "Password updated successfully!"
  else
    redirect_back(fallback_location: root_path, alert: current_user.errors.full_messages.join(" ").html_safe)
  end
end

end
