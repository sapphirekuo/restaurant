class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]


  def show
    @commented_restaurants = @user.restaurants.uniq
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

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end
end
