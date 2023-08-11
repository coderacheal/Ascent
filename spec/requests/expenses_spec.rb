require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  before(:each) do
    @user = User.create!(name: 'Racheal', email: 'racheal@gmail.com', password: '123456',
                         password_confirmation: '123456')

    sign_in @user

    @category_one = Category.create(name: 'Groceries', user_id: @user.id)
    
     # Attach an image to the @category_one instance
    image_path = Rails.root.join('spec', 'fixtures', 'files', 'profile.png')
    @category_one.image.attach(io: File.open(image_path), filename: 'profile.png', content_type: 'image/png')

    @expense_one = Expense.create(name: 'Olive Oil', amount: 25, author_id: @user.id)

    @category_one.expenses << @expense_one

    @category = @category_one
  end

  describe 'GET expenses/' do
    it 'returns http success' do
      get category_expenses_path(category_id: @category.id, id: @expense_one.id)
      expect(response).to have_http_status(:success)
    end

    it 'returns http success' do
      get new_category_expense_path(@category_one)
      expect(response).to have_http_status(:success)
    end
  end
end
