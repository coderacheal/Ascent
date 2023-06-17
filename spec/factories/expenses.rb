FactoryBot.define do
    factory :expense do
      name { 'Example Expense' }
      amount { 10 }
      association :user, factory: :user
      categories { [association(:category)] }
    end
end
  