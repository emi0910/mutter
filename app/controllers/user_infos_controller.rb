class UserInfosController < ApplicationController
  before_action :logged_in_user, only: [:create, :update]
  before_action :correct_user, only: [:create, :update]

  def create
    @userinfo = UserInfo.new(userinfo_params)
    if @userinfo.save
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'users/edit'
    end
  end

  def update
    @userinfo = @user.user_info
    if @userinfo.update_attributes(userinfo_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'users/edit'
    end
  end

  private

  def correct_user
    @user = User.find(userinfo_params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def userinfo_params
    params.require(:user_info).permit(:description, :icon, :icon_cache, :remove_icon, :user_id)
  end
end
