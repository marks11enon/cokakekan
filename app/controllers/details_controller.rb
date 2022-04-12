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
    total_for_each
  end

  def edit
    @detail = Detail.find(params[:id])
  end

  def update
    @detail = Detail.find_by(user_id: current_user.id, id: params[:id])
    @detail.update(detail_params)
    redirect_to month_details_path(@detail.month_id)
  end

  def destroy
    @detail = Detail.find_by(user_id: current_user.id, id: params[:id])
    @detail.destroy
    flash[:alert] = "明細を削除しました。"
    redirect_to month_details_path(@detail.month_id)
  end

  private
  def detail_params
    params.require(:detail).permit(:income, :spending, :note, :player, :date, :category_id)
  end

  def detail_params_edit
    params.require(:detail).permit(:income, :spending, :note, :player, :date, :category_id)
  end

  def total_for_each
    @income_total = Detail.where(user_id: current_user.id, month_id: params[:id]).includes(:user).sum(:income)
    @spending_total = Detail.where(user_id: current_user.id, month_id: params[:id]).includes(:user).sum(:spending)
    @balance_of_payments = @income_total - @spending_total
  end
end
