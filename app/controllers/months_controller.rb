class MonthsController < ApplicationController
  def new
    @month = Month.new
    @latest_month = Month.where(user_id: current_user.id).includes(:user).order(month: :desc).first
  end

  def create
    @month = Month.new(month_params)
    @month.user_id = current_user.id


    # 以下、要確認

    @data = Month.find_by(user_id: current_user.id, month: @month.month)
    @month.balance_last = @month.balance

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

    #ここまで
  end

  def index
    @months = Month.where(user_id: current_user.id).includes(:user).order(month: :desc)
    @month = Month.new
    # @column_chart = Month.where(user_id: current_user.id).includes(:user).order(month: :asc).last(12).pluck(:month, :balance_last)
    # @colum_chart_max =Month.where(user_id: current_user.id).includes(:user).order(month: :asc).last(12).pluck(:balance_last).max
  end

  def show
    @month = Month.find(params[:id])
  end

  def edit
    @month = Month.find(params[:id])
  end

  def update
    month = Month.find(params[:id])
    month.update(month_params)
    redirect_to months_path
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
end
