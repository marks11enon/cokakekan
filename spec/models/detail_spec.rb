require 'rails_helper'

RSpec.describe Detail, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @month = FactoryBot.create(:month, user_id: @user.id)
    @category = FactoryBot.create(:category)
    @detail = FactoryBot.build(:detail, user_id: @user.id, month_id: @month.id, category_id: @category.id)
  end

  describe "入出金明細の登録" do
    it "全ての情報があれば登録できる" do
      # user = FactoryBot.create(:user)
      # month = FactoryBot.create(:month, user_id: user.id)
      # category = FactoryBot.create(:category)
      # detail = FactoryBot.build(:detail)
      expect(@detail).to be_valid
    end

    it "日付がなければ登録できない" do
      @detail.date = nil
      expect(@detail).to be_invalid
    end

    it "カテゴリがなければ登録できない" do
      @detail.category_id = nil
      expect(@detail).to be_invalid
    end

    it "メモが１５文字以内でないと登録できない" do
      @detail.note = "1234567890123456"
      expect(@detail).to be_invalid
    end
  end
end
