class HomesController < ApplicationController
  skip_before_action :authenticated_this_month, only:[:top]

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
        @income_total = Detail.where(user_id: current_user.id, month_id: @month.id, status: :true).where("date <= ?", Date.today).includes(:month).sum(:income)
        @spending_total = Detail.where(user_id: current_user.id, month_id: @month.id, status: :true).where("date <= ?", Date.today).includes(:month).sum(:spending)
        @balance_of_payments = @income_total - @spending_total
        @month.balance_last = @month.balance + @balance_of_payments
      end
    end
    @detail = Detail.where(user_id: current_user.id, month_id: @month.id) if @month.present?
    @budget = Budget.where(user_id: current_user.id, month_id: @month.id) if @month.present?

    if @detail.present?
    # pie_chart
      target_month = Month.find_by(user_id: current_user, month: Date.current.strftime("%Y-%m-01"))
      @sum_result = Detail.where(month_id: target_month.id).group(:category).sum(:spending)
      @output_result = {} # 空のハッシュを用意
      @sum_result.each do |result|
        @output_result[result[0].name] = result[1]
      end
      @spending_sum = Detail.where(user_id: current_user.id, month_id: @month.id, status: :true).sum(:spending)
      @details = Detail.where(user_id: current_user.id)
      @spending_total_by_him = Detail.where(user_id: current_user.id, month_id: @month.id, player: "by_him").sum(:spending)
      @spending_total_by_her = Detail.where(user_id: current_user.id, month_id: @month.id, player: "by_her").sum(:spending)
      @spending_calculate = @spending_total_by_him - @spending_total_by_her
    end
  end

  private
  def date_today
    @now = Date.today
    @this = @now.month
  end

end
