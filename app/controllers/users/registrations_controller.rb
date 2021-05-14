class Users::RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :find_materials
  before_action :find_levels
  #before_action :find_citytowns

  
  
  protected
  # If you have extra params to permit, append them to the sanitizer.
    def configure_permitted_parameters
      added_attrs = [:email, :full_name, :first_name, :last_name,
        :phone_contact, :whatsapp_contact, :matricule,
        :role, :city, :school_name, :class_name,
        :level_id, :material_id, :gender, :avatar, :slug]

        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs

    end
    

    private
    #enable material
    def find_materials
      @materials = Material.all
    end

    #enable level
    def find_levels
      @levels = Level.all
    end

end


