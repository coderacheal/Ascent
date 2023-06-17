require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let(:user) { create(:user) }

  describe 'GET /categories' do
    it 'returns http success' do
      sign_in user # Authenticate the user using Devise's sign_in helper
      get '/categories'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /categories/new' do
    it 'returns http success' do
      sign_in user # Authenticate the user using Devise's sign_in helper
      get '/categories/new'
      expect(response).to have_http_status(:success)
    end
  end
end
