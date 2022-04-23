FactoryBot.define do
  factory :month do
    month { "#{Date.today.beginning_of_month}" }
    balance { "150000" }
    balance_last { "150000" }
  end
end
