require 'rails_helper'

RSpec.describe 'Expense Feature', type: :feature do
  before(:each) do
    @user_one = User.create!(name: 'Racheal', email: 'racheal@gmail.com', password: '123456',
                             password_confirmation: '123456')

    visit new_user_session_path
    fill_in 'user_email', with: @user_one.email
    fill_in 'user_password', with: @user_one.password
    click_button 'Log in'

    @category_one = Category.create(name: 'Groceries', user_id: @user_one.id)

    @category_two = Category.create(name: 'Investment', user_id: @user_one.id)

    # Attach an image to the @category_one instance
    image_path = Rails.root.join('spec', 'fixtures', 'files', 'profile.png')
    @category_one.image.attach(io: File.open(image_path), filename: 'profile.png', content_type: 'image/png')

    @expense_one = Expense.create(name: 'Olive Oil', amount: 25, author_id: @user_one.id)

    # Associate the Expense with the Category
    @category_one.expenses << @expense_one
  end

  describe 'Index Expenses Action' do
    it 'shows all expenses for a category' do
      visit category_expenses_path(category_id: @category_one.id)
      expect(page).to have_content('Groceries')
    end

    it 'display the expense name' do
      visit category_expenses_path(category_id: @category_one.id)
      expect(page).to have_content('Olive Oil')
    end

    it 'display expense amount' do
      visit category_expenses_path(category_id: @category_one.id)
      expect(page).to have_content('$25.00')
    end
  end
end
