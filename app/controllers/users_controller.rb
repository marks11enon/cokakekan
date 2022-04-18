class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update
    redirect_to my_page_path
  end

  private
  def user_params
    params.require(:user).premit(:name, :email)
  end
end
