class MonthsController < ApplicationController
  def new
    @month = Month.new
    @latest_month = Month.where(user_id: current_user.id).includes(:user).order(month: :desc).first
  end

  def create
    @month = Month.new(month_params)
    @data = Month.find_by(user_id: current_user.id, month: @month.month)
    @month.balance_last = @month.balance
    if !@data.present?
      @month.user_id = current_user.id
      if @month.save
        redirect_back_or_to months_path, success: '家計簿を追加しました'
      else
        redirect_back_or_to months_path, danger: '追加できませんでした'
      end
    else
      redirect_back_or_to months_path, danger: '同じ月は追加できません'
    end
  end

  def index
    @months = Month.where(user_id: current_user.id).includes(:user).order(month: :desc)
    @month = Month.new
    @column_chart = Month.where(user_id: current_user.id).includes(:user).order(month: :asc).last(12).pluck(:month, :balance_last)
    @colum_chart_max =Month.where(user_id: current_user.id).includes(:user).order(month: :asc).last(12).pluck(:balance_last).max
  end

  def show
    @month = Month.find(params[:id])
  end

  def edit
  end

  def destroy
  end

  # private
  # def month_params
  #  params.require(:month).permit(:user_id, :month)
  # end
end
