class HomesController < ApplicationController

  def top
  end

  def main_page
    date_today
    @user = User.find(current_user.id)
    @months = Month.where(user_id: current_user.id)
    if @months.present?
      @this_month = Date.today.all_month
      @month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
      if @month.present?
        @income_total_true_before_today = Detail.where(user_id: current_user.id, month_id: params[:month_id], status: :true).where("date <= ?", Date.today).includes(:month).sum(:income)
        @spending_total_true_before_today = Detail.where(user_id: current_user.id, month_id: params[:month_id], status: :true).where("date <= ?", Date.today).includes(:month).sum(:spending)
        @balance_of_payments = @income_total_true_before_today - @spending_total_true_before_today
        @month.balance_last = @month.balance + @balance_of_payments
      end
    end
    @detail = Detail.where(user_id: current_user.id, month_id: @month.id) if @month.present?
    @budget = Budget.where(user_id: current_user.id, month_id: @month.id) if @month.present?
  end

  private
  def date_today
    @now = Date.today
    @this = @now.month
  end
end
