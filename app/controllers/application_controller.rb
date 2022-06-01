class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticated_this_month
  before_action :search

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def search
    #@detail = Detail.where(user_id: current_user.id)
    # ransackの検索メソッド
    @q = Detail.ransack(params[:q])
    # detailsの検索結果一覧
    @search_details = @q.result(distinct: true).order(date: :desc, id: :desc).page(params[:page]).per(10)
  end

  def after_sign_in_path_for(resource)
    if @authenticated_this_month.present?
      main_page_path
    else
      new_month_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private
  def log_in(user)
    session[:user_id] = user.id
  end

  def authenticated_this_month
    if user_signed_in?
      @authenticated_this_month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
    else
      @authenticated_this_month = Month.find_by(month: Date.today.beginning_of_month)
    end
  end
end
