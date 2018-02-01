class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @followings = @user.followings
    @followers = @user.followers
    @commented_restaurants = @user.restaurants.uniq
    @favorited_restaurants = @user.favorited_restaurants
  end

  def edit
    if @user != current_user
      flash[:alert] = "you can only edit your own profile"
      redirect_to user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "user was successfully updated"
      redirect_to user_path(@user)
    else
      flash[:alert] = "user was failed to update"
      render:edit
    end
  end

  def friend_list
    @friends = current_user.all_friends

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end
end
