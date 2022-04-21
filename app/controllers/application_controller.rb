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
    # ransackの検索メソッド
    @q = Detail.ransack(params[:q])
    # detailsの検索結果一覧
    @search_details = @q.result(distinct: true).order(date: :asc, id: :asc).page(params[:page]).per(5)
  end


  private
  def authenticated_this_month
    @authenticated_this_month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
  end
end
