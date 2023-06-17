require 'rails_helper'
require 'devise'

RSpec.describe 'Categories', type: :feature do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  scenario 'user views all categories and their total amounts' do
    category1 = create(:category, user: user)
    category2 = create(:category, user: user)
    expense1 = create(:expense, categories: [category1], user: user)
    expense2 = create(:expense, categories: [category2], user: user)

    visit categories_path

    expect(page).to have_content(category1.name)
    expect(page).to have_content(category2.name)
    expect(page).to have_content('Total Amount: 10') 
  end

  scenario 'user creates a new category' do
    visit new_category_path

    fill_in 'Name', with: 'Test Category'

    click_button 'Save'
    expect(current_path).to eql categories_path
  end
end
