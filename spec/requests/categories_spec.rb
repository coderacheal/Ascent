require 'rails_helper'

RSpec.describe 'Categories', type: :request do

  before(:each) do
    @user = User.create!(name: 'Racheal', email: 'racheal@gmail.com', password: '123456',
                             password_confirmation: '123456')
    
    sign_in @user 
  end
  
  describe 'GET categories/' do
    it 'returns http redirect' do
      get '/categories/'
      expect(response).to have_http_status(:success)
    end

    it 'returns http redirect' do
      get '/categories/new'
      expect(response).to have_http_status(:success)
    end
  end
end
