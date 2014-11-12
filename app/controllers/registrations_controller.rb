class RegistrationsController < Devise::RegistrationsController
  def new
    @days = %w[monday tuesday wednesday thursday friday saturday sunday]
    @signup_request = SignupRequest.find_by(hex_id: params[:hex_id])
    build_resource({})
    @validatable = devise_mapping.validatable?
    if @validatable
      @minimum_password_length = resource_class.password_length.min
    end
    respond_with self.resource
  end
   
   def create
    build_resource(sign_up_params)
    resource.desc_words = resource.desc_words.split(',')
    time_slots = TimeSlot.all_time_slots(params[:day])
    resource.time_slots << time_slots

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        # respond_with resource, location: after_sign_up_path_for(resource)
        hash = {user: User.last, game: User.last.game, platform: User.last.game.platform, time_slots: User.last.time_slots, traits: User.last.traits, match_traits: User.last.match_traits, outside_activities: User.last.outside_activities}
        render json: hash.to_json
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end
  
  protected

end