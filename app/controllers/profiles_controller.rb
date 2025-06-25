class ProfilesController < ApplicationController
  skip_before_action :ensure_profile_created, only: %i[ new create ]

  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to homes_path, notice: "プロフィールを登録しました"
    else
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:nickname)
  end
end
