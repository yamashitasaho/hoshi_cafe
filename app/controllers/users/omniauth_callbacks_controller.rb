class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: :google_oauth2
    # verify_authenticity_token = CSRF（Cross-Site Request Forgery）攻撃を防ぐためのセキュリティチェック
    #  をgoogleはトークンを持っていないのでスキップ

    def google_oauth2
        callback_for(:google)
    end

    def callback_for(provider) # provider = 「認証サービスの提供者」
      @user = User.from_omniauth(request.env["omniauth.auth"])
      # request.env['omniauth.auth'] = Google から返ってきた認証情報（メール、ID など）
      # User.from_omniauth = その情報からユーザーを作成または取得

      if @user.persisted? # ユーザーが登録済みか
        sign_in_and_redirect @user, event: :authentication # Google / GitHub などの OAuth でログイン
        set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format? # ブラウザからアクセスされているか
      else
        session["devise.#{provider}_data"] = request.env["omniauth.auth"].except(:extra) # 不要な情報は戸除いて、Google から返ってきたユーザー情報
        redirect_to new_user_registration_url # /users/sign_up へのリンク
      end
    end

    def failure # 失敗
      redirect_to root_path
    end
end
