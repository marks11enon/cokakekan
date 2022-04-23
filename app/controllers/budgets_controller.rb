class BudgetsController < ApplicationController

  def new
    @budget = Budget.new
  end

  def create
    @budgets = Budget.all # 追加
    @add = Budget.new(budget_params)
    if !authenticate_budget
      @add.month_id = params[:month_id]
      @add.user_id = current_user.id
      if @add.save
        render :index, success: '予算を設定しました'
      else
        render :index, danger: '予算を設定できませんでした'
      end
    else
      render :index, danger: '予算は既に設定されています'
    end
  end

  def index
    @month = Month.find_by(user_id: current_user.id, id: params[:month_id])
    authenticate_budget
    @budgets = Budget.where(user_id: current_user.id).order(month_id: :asc, id: :asc)
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

  def authenticate_budget
    @budget = Budget.find_by(user_id: current_user.id, month_id: params[:month_id])
  end
end
