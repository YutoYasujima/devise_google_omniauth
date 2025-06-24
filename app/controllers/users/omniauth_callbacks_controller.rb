# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
      redirect_to homes_path
    else
      session["devise.google_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url, alert: "Googleログインに失敗しました"
    end
  end

  # OmniAuth が自動的に失敗した場合（ユーザーがキャンセルした、認証が壊れた等）に呼ばれる
  # トップページへリダイレクトして、失敗メッセージを表示
  def failure
    redirect_to root_path, alert: "Googleログインに失敗しました"
  end
end
