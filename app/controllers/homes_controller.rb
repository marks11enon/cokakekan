class HomesController < ApplicationController

  def top
  end

  def main_page
    date_today
  end

  private
  def date_today
    @now = Date.today
    @this_month = @now.month
  end
end
