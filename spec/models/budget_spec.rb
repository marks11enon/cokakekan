require 'rails_helper'

RSpec.describe Budget, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @month = FactoryBot.create(:month, user_id: @user.id)
    @budget = FactoryBot.build(:budget, user_id: @user.id, month_id: @month.id)
  end

  describe "予算登録" do
    it "全ての情報があれば登録できる" do
      expect(@budget).to be_valid
    end

    it "予算がなければ登録できない" do
      @budget.amount = nil
      expect(@budget).to be_invalid
    end
  end
end
