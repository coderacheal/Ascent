require 'rails_helper'

RSpec.describe 'Category Feature', type: :feature do
  before(:each) do
    @user_one = User.create!(name: 'Racheal', email: 'racheal@gmail.com', password: '123456',
                             password_confirmation: '123456')

    visit new_user_session_path
    fill_in 'user_email', with: @user_one.email
    fill_in 'user_password', with: @user_one.password
    click_button 'Log in'

    # current_user = @user_one
    @category_one = Category.create(name: 'Groceries', user_id: @user_one.id)

    @category_two = Category.create(name: 'Investment', user_id: @user_one.id)


    # Attach an image to the @category_one instance
    image_path = Rails.root.join('spec', 'fixtures', 'files', 'profile.png')
    @category_one.image.attach(io: File.open(image_path), filename: 'profile.png', content_type: 'image/png')

    @expense_one = Expense.create(name: 'Olive Oil', amount: 25, author_id: @user_one.id)

    # Associate the Expense with the Category
    @category_one.expenses << @expense_one
  end

  describe 'Index Category Action' do
    it 'shows all categories' do
      visit categories_path
      expect(page).to have_content('Add category')
    end
  end

  describe 'Show Category Action' do
    it 'shows a category' do
      visit categories_path
      expect(page).to have_content('Groceries')
    end

    it 'contains total amount of transactions' do
      visit categories_path
      expect(page).to have_content('Investment')
    end

    it 'contains total of transactions' do
      visit categories_path
      expect(page).to have_content('Total $0.00')
    end
  end

  describe 'New Category Action' do
    it 'redirects to the form to add new category' do
      visit new_category_path
      expect(page).to have_button('Save', class: 'save_category_btn')
    end
  end
end
