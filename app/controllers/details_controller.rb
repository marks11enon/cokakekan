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
    @detail = Detail.find(params[:id])
  end

  def update
    @detail = Detail.find_by(user_id: current_user.id, id: params[:id])
    @detail.update(detail_params)
    redirect_to month_details_path(@detail.month_id)
  end

  private
  def detail_params
    params.require(:detail).permit(:income, :spending, :note, :player, :date, :category_id)
  end

  def detail_params_edit
    params.require(:detail).permit(:income, :spending, :note, :player, :date, :category_id)
  end
end
