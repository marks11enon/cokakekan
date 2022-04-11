class BudgetsController < ApplicationController

  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    @budget.user_id = current_user.id
    @budget.save
    redirect_to budgets_path
  end

  def index
    @budgets = Budget.all.order(month_id: :asc, id: :asc)
  end

  def destroy
    @budget = Budget.find(params[:id])
    @budget.delete
    redirect_to budgets_path
  end

  private
  def budget_params
    params.require(:budget).permit(:month_id, :amount)
  end
end
