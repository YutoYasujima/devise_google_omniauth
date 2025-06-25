class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :ensure_profile_created

  protected

  # ログイン後のリダイレクト先を変更
  def after_sign_in_path_for(resource)
    homes_path
  end

  private

  # ログイン中のUserに紐付くProfileがあるか確認
  def ensure_profile_created
    return unless user_signed_in?

    # 除外したいコントローラーやアクション（無限ループ防止）
    return if controller_path == "profiles" && %w[new create].include?(action_name)

    # Profileがないなら登録画面にリダイレクト
    unless current_user.profile.present?
      redirect_to new_profile_path, alert: "プロフィール情報を登録してください"
    end
  end
end
