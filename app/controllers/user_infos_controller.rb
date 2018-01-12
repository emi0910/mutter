class UserInfosController < ApplicationController
  before_action :logged_in_user, only: :update
  before_action :correct_user, only: :update

  def update
    if @userinfo.update_attributes(userinfo_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'users/edit'
    end
  end

  private

  def correct_user
    @userinfo = UserInfo.find(params[:id])
    @user = @userinfo.user
    redirect_to(root_url) unless current_user?(@user)
  end

  def userinfo_params
    params.require(:user_info).permit(:description, :icon, :icon_cache, :remove_icon)
  end
end
