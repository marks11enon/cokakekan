class BudgetsController < ApplicationController

  def new
    @budget = Budget.new
  end

  def create
    @budgets = Budget.all # 追加
    @budget = Budget.new(budget_params)
    if !this_month_budget
      @budget.user_id = current_user.id
      @budget.month_id = @month.id

      if @budget.save
        # redirect_to budgets_path, success: "予算を登録しました。"
        render :index
      else
        # redirect_to budgets_path, danger: "予算を設定できませんでした。"
        render :index
      end
    else
      # redirect_to budgets_path, danger: "予算は既に設定されています。"
      render :index
    end
  end

  def index
    @budgets = Budget.all.order(month_id: :asc, id: :asc)
    @month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
    @budget = Budget.new(budget_params)
  end

  def destroy
    @budgets = Budget.all # 追加
    @budget = Budget.find(params[:id])
    @budget.destroy
  end

  private
  def budget_params
    params.permit(:amount)
  end

  def this_month_budget
    @month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
    @this_month_budget = Budget.find_by(user_id: current_user.id, month_id: @month.id)
  end
end
