require 'rails_helper'

RSpec.describe Month, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @month = FactoryBot.build(:month)
  end

  describe '家計簿登録' do
    it "全ての情報があれば登録できる" do
      user = FactoryBot.create(:user)
      month = FactoryBot.build(:month)
      month.user_id = user.id
      expect(month).to be_valid
    end

    it "ユーザーIDがなければ登録できない" do
      expect(@month).to be_invalid
    end

    it "登録月がなければ登録できない" do
      @month.month = nil
      @month.user_id = @user.id
      expect(@month).to be_invalid
    end

    it "口座残高がなければ登録できない" do
      @month.month = nil
      @month.user_id = @user.id
      expect(@month).to be_invalid
    end
  end
end
