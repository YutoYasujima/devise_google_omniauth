class HomesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.includes(:profile).find(current_user.id)
  end
end
