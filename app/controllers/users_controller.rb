class UsersController < ApplicationController

  def show
    @user = current_user
    @month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_my_page_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
