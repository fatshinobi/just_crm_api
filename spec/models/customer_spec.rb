require "rails_helper"

RSpec.describe "Customer", :type => :model do
  context 'when new customer is created' do
    before do
      @customer = FactoryBot.build(:customer)
    end

    it 'name must not be empty' do
      @customer.name = nil
      expect(@customer.valid?).to be false
      expect(@customer.errors[:name].any?).to be true
    end

    it 'name should be unique' do
      the_same_customer = FactoryBot.create(:customer)
      @customer.name = the_same_customer.name

      expect(@customer.valid?).to be false
      expect(@customer.errors[:name].first).to eq 'is already taken'
    end

    it 'name should not be too small' do
      @customer.name = '12'
      expect(@customer.valid?).to be false
      expect(@customer.errors[:name].any?).to be true
    end

    describe 'should add and update tags' do
      before do
        tags = 'tag 1, tag 2, tag 3'
        @customer.tags = tags
        @customer.save
        @customer.reload
      end

      it 'includes right qty of tags' do
        expect(@customer.tags_array.size).to eq 3
      end

      it 'includes right records' do
        expect(@customer.tags_array.include?('tag 1')).to be true
        expect(@customer.tags_array.include?('tag 2')).to be true
        expect(@customer.tags_array.include?('tag 3')).to be true
      end
    end

    describe 'should have conditions' do
      it 'active by default' do
        expect(@customer.condition).to eq 0
        expect(@customer.get_condition).to eq :active
      end

      it 'can be removed' do
        @customer.set_condition :removed
        expect(@customer.condition).to eq 2
        expect(@customer.get_condition).to eq :removed
      end

      it 'can be stoped' do
        @customer.set_condition :stoped
        expect(@customer.condition).to eq 1
        expect(@customer.get_condition).to eq :stoped
      end

      it 'can be active' do
        @customer.set_condition :active
        expect(@customer.condition).to eq 0
        expect(@customer.get_condition).to eq :active
      end
    end

    context 'when user setted' do
      it 'user must not be empty' do
        @customer.user = nil
        expect(@customer.valid?).to be false
        expect(@customer.errors[:user].any?).to be true
      end

      it 'should have user' do
        @customer.user = FactoryBot.create(:user)
        expect(@customer.valid?).to be true
      end

    end

    it 'have people' do
      @customer.people << FactoryBot.create(:person, name: 'person 1')
      @customer.people << FactoryBot.create(:person, name: 'person 2')

      expect(@customer.people.size).to eq 2
      expect(@customer.people.detect{|rec| rec.name == 'person 1'}).not_to be false
      expect(@customer.people.detect{|rec| rec.name == 'person 2'}).not_to be false
    end
  end

end