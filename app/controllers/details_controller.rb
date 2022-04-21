class DetailsController < ApplicationController
  before_action :total_for_each
  require 'csv'

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
    @this_month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
    @month = Month.find_by(user_id: current_user.id, id: params[:month_id])
    @details = Detail.where(user_id: current_user.id, month_id: params[:month_id]).includes(:month).order(date: :asc, id: :asc)

    respond_to do |format|
      format.html
      format.csv do |csv|
        send_posts_csv(@details)
      end
    end
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
    @income_total = Detail.where(user_id: current_user.id, month_id: params[:id]).includes(:month).sum(:income)
    @spending_total = Detail.where(user_id: current_user.id, month_id: params[:id]).includes(:month).sum(:spending)
    @income_total_true_before_today = Detail.where(user_id: current_user.id, month_id: params[:month_id], status: :true).where("date <= ?", Date.today).includes(:month).sum(:income)
    @spending_total_true_before_today = Detail.where(user_id: current_user.id, month_id: params[:month_id], status: :true).where("date <= ?", Date.today).includes(:month).sum(:spending)
    @balance_of_payments = @income_total - @spending_total
  end

  def send_posts_csv(details)
    bom = "\uFEFF"
    csv_data = CSV.generate(bom) do |csv|
      column_names = %w(日付 カテゴリ名 収入 支出 支払元)
      csv << column_names
      details.each do |detail|
        column_values = [
          detail.date.strftime("%-m月%-d日"), # date
          detail.category.name, # category_id
          detail.income, # income
          detail.spending, # spending
          detail.player_i18n, # palyer
        ]
        csv << column_values
      end
    end
    send_data(csv_data, filename: "投稿一覧.csv")
  end
end
