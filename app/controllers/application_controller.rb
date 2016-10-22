class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :password, :password_confirmation,:email, :game_id, :personal_rank, :mic_style, :play_style, :desc_words, :date_of_birth, :gamertag, :occupation, :username, :postal_code, { trait_ids: []}, { match_trait_ids: []}, { outside_activity_ids: []} ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :username, :email, :password, :remember_me])
    # devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :password, :password_confirmation,:email, :game_id, :personal_rank, :mic_style, :play_style, :desc_words, :date_of_birth, :gamertag, :occupation, :username, :postal_code, { trait_ids: []}, { match_trait_ids: []}, { outside_activity_ids: []} ) }
    # devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
  end
end
