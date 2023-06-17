require 'rails_helper'

RSpec.describe Category, type: :model do
  before :all do
    @user = User.create(name: 'Nii Armah')
    @category = Category.create(name: 'Travel', user_id: @user.id)
  end

  
  describe 'Association' do
    it 'should belong to a user' do
      expect(@category.user_id).to eq(@user.id)
    end

    it 'should have many expenses' do
      relation = Category.reflect_on_association(:expenses)
      expect(relation.macro).to eq(:has_and_belongs_to_many)
    end
  end

  describe 'Validation' do
    it 'should validate the presence of a name' do
      @category.name = nil
      expect(@category).to_not be_valid
    end

    it 'should validate the length of the name' do
      @category.name = 'Ama' * 19
      expect(@category).to_not be_valid
    end
  end

end
