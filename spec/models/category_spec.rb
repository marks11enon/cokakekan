require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    @category = FactoryBot.build(:category)
  end

  describe "カテゴリ新規登録" do
    it "カテゴリ名とimage_idがあれば登録できる" do
      expect(@category).to be_valid
    end

    it "カテゴリ名がなければ登録できない" do
      @category.name = nil
      expect(@category).to be_invalid
    end
  end
end
