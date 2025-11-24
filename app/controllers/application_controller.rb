class ApplicationController < ActionController::Base
  # 指定されたコントローラーのアクションが実行される前に、ユーザーがログインしているか
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username ])
  end
end
