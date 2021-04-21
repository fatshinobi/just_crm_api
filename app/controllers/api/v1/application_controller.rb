module Api
  module V1
    #class ApplicationController < ActionController::API
    class ApplicationController < ActionController::Base
      include DeviseTokenAuth::Concerns::SetUserByToken
      before_action :authenticate_api_v1_user!
      #before_action :authenticate_user!
      before_action :configure_permitted_parameters, if: :devise_controller?
      respond_to :json

      protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
      end

    end
  end
end