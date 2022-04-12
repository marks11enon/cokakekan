class MonthsController < ApplicationController
  def new
    @month = Month.new
    @latest_month = Month.where(user_id: current_user.id).includes(:user).order(month: :desc).first
  end

  def create
    @month = Month.new(month_params)

    @data = Month.find_by(user_id: current_user.id, month: @month.month)
    @month.balance_last = @month.balance #月初残高と月末残高を同一と定義

    if !@data.present?
      @month.user_id = current_user.id
      if @month.save
        redirect_to months_path
      else
        render :new, danger
      end
    else
      redirect_to months_path
    end
  end

  def index
    @months = Month.all.order(month: :desc)
    @month = Month.new
    @month_chart = Month.where(user_id: current_user.id).includes(:user).order(month: :asc).last(12).pluck(:month, :balance_last)
    @month_chart_max = Month.where(user_id: current_user.id).includes(:user).order(month: :asc).last(12).pluck(:balance_last).max
  end

  def edit
    @month = Month.find_by(user_id: current_user.id, id: params[:id])
  end

  def update
    @month = Month.find_by(user_id: current_user.id, id: params[:id])
    total_for_each
    @month.update(month_params)
    @month.balance_last = @month.balance + @balance_of_payments
    if @month.save
      redirect_to months_path, notice: "月初残高を更新しました。"
    else
      render :edit, danger: "更新できませんでした。"
    end
  end

  def destroy
    @month = Month.find(params[:id])
    @month.destroy
    flash[:alert] = "#{@month.month.strftime("%Y年 %m月")}の家計簿は削除しました。"
    redirect_to months_path
  end

  private
  def month_params
    params.require(:month).permit(:user_id, :month, :balance)
  end

  def total_for_each
    @income_total = Detail.where(user_id: current_user.id, month_id: params[:id]).includes(:user).sum(:income)
    @spending_total = Detail.where(user_id: current_user.id, month_id: params[:id]).includes(:user).sum(:spending)
    @balance_of_payments = @income_total - @spending_total
  end
end
