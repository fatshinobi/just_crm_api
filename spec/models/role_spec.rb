require "rails_helper"

RSpec.describe "Role", :type => :model do
  context 'when new role is created' do
    before do
      @role = FactoryBot.build(:role)
    end

    it 'name must not be empty' do
      @role.name = nil
      expect(@role.valid?).to be false
      expect(@role.errors[:name].any?).to be true
    end

    it 'name should be unique' do
      the_same_role = FactoryBot.create(:role)
      @role.name = the_same_role.name

      expect(@role.valid?).to be false
      expect(@role.errors[:name].first).to eq 'is already taken'
    end

  end
end