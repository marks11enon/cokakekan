FactoryBot.define do
  factory :detail do
    spending { 10000 }
    note { "ランチ" }
    player { "by_her" }
    date { "#{Date.today.beginning_of_month}" }
    status { "true" }
  end
end
