class BudgetsController < ApplicationController

  def new
    @budget = Budget.new
  end

  def index
  end

  def show
  end

  private
  def budget_params
    params.require(:budget).permit(:amount)
  end
end
