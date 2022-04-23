require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end


    it 'nameと,email, password, password_confirmationが存在すれば登録できる' do
      expect(@user).to be_valid
    end

    it 'passwordが7文字以上で登録できる' do
      @user.password = nil
      @user.password_confirmation = @user.password
      expect(@user).to be_valid
    end

    it "nameが空だと登録できない" do
      @user.name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end
    it "emailが空だと登録できない" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "emailに一意性がないと登録できない" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
  end
end
