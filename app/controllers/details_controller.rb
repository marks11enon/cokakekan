class DetailsController < ApplicationController

  def new
    @detail = Detail.new
  end

  def create
    detail = Detail.new(detail_params)
    detail.user_id = current_user.id
    detail.month_id = params[:month_id]
    detail.save
    redirect_to month_details_path
  end

  def index
    @details = Detail.where(user_id: current_user.id, month_id: params[:month_id]).includes(:month).order(date: :asc, id: :asc)
  end

  def show
  end

  private
  def detail_params
    params.require(:detail).permit(:category_id, :income, :spending, :note, :player, :date)
  end
end
