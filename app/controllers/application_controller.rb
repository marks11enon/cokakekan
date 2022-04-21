class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticated_this_month
  before_action :set_search

  def set_search
    @search = Detail.ransack(params[:q])
    # ransackの検索メソッド
    @search_details = @search.result(distinct: true).order(created_at: "DESC").includes(:user).page(params[:page]).per(5)
    # detailsの検索結果一覧
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private
  def authenticated_this_month
    @authenticated_this_month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
  end
end
