class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		# strong parametersを設定し、idnameを許可
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :idname, :password, :password_confirmation])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:idname, :password, :remember_me])
	end
end