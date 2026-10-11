class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @orders = @user.orders.recent.limit(5).includes(:restaurant, :items)
    @total_orders = @user.orders.count
    @total_spent = @user.orders.sum(:total)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: "Your profile has been updated successfully."
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :address)
  end
end
