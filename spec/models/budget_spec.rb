require 'rails_helper'

RSpec.describe Budget, type: :model do
  it "全てあれば有効な状態である" do
    user = FactoryBot.create(:user)
    month = FactoryBot.create(:month, user_id: user.id)
    budget = FactoryBot.build(:budget)
    budget.month_id = month.id
    budget.user_id = user.id
    expect(budget).to be_valid
  end





end
