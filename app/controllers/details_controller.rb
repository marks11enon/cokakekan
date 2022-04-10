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

  def edit
    detail.month_id = params[:month_id]
    @detail = detail.find(params[:id])
  end

  private
  def detail_params
    params.require(:detail).permit(:income, :spending, :note, :player, :date, :category_id)
  end

  def detail_params_edit
    params.require(:detail).permit(:income, :spending, :note, :player, :date, :category_id)
  end
end
