class BudgetsController < ApplicationController

  def new
    @budget = Budget.new
  end

  def create
    @add = Budget.new(budget_params)
    if !this_month_budget
      @add.user_id = current_user.id
      @add.month_id = @month.id

      if @add.save
        redirect_to budgets_path, success: "予算を登録しました。"
      else
        redirect_to budgets_path, danger: "予算を設定できませんでした。"
      end
    else
      redirect_to budgets_path, danger: "予算は既に設定されています。"
    end
  end

  def index
    @budgets = Budget.all.order(month_id: :asc, id: :asc)
    @month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
    @budget = Budget.new
  end

  def destroy
    @budget = Budget.find(params[:id])
    @budget.delete
    redirect_to budgets_path
  end

  private
  def budget_params
    params.permit(:amount)
  end

  def this_month_budget
    @month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
    @budget = Budget.find_by(user_id: current_user.id, month_id: @month.id)
  end
end
