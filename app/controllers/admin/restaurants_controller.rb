class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin


  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "restaurant was successfully created"
    else
      flash[:alaert] = "reataurant was failed to create"
    end
  end

  private

  def restaurant_params
    params.require(:reataurant).permit(:name, :opening_hours, :tel, :address, :description)
  end
  
end
