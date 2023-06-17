require 'rails_helper'
require 'devise'

RSpec.describe 'Expenses', type: :feature do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }

  before do
    login_as(user, scope: :user)
  end

  scenario 'user views expenses of a category' do
    expense1 = create(:expense, categories: [category], user:)
    expense2 = create(:expense, categories: [category], user:)

    visit category_expenses_path(category)

    expect(page).to have_content(expense1.name)
    expect(page).to have_content(expense2.name)
    expect(page).to have_content('Total Amount: 20')
  end

  scenario 'user creates a new expense' do
    visit new_category_expense_path(category)

    fill_in 'Name', with: 'Test Expense'
    fill_in 'Amount', with: 10

    click_button 'Add Expense'

    expect(current_path).to eql category_expenses_path(category_id: category.id)
  end
end
