require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー新規登録" do

    it "名前、メールアドレス、パスワードがある場合、有効である" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it "名前がなければ登録できない" do
      expect(FactoryBot.build(:user, name: "")).to_not be_valid
    end

    it "メールアドレスがなければ登録できない" do
      expect(FactoryBot.build(:user, email: "")).to_not be_valid
    end

    it "メールアドレスが重複していたら登録できない" do
      user1 = FactoryBot.create(:user,name: "taro", email: "taro@example.com")
      expect(FactoryBot.build(:user, name: "ziro", email: user1.email)).to_not be_valid
    end

    it "パスワードがなければ登録できない" do
      expect(FactoryBot.build(:user, password: "")).to_not be_valid
    end

    it "パスワードが7文字以上でないと登録できない" do
      expect(FactoryBot.build(:user, password: "123456")).to_not be_valid
    end

    it "password_confirmationとpasswordが異なる場合保存できない" do
      expect(FactoryBot.build(:user,password:"password", password_confirmation: "passward")).to_not be_valid
    end
  end
end
