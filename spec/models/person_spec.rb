require "rails_helper"

RSpec.describe "Person", :type => :model do
  context 'when new person is created' do
    before do
      @person = FactoryBot.build(:person)
    end

    it 'name must not be empty' do
      @person.name = nil
      expect(@person.valid?).to be false
      expect(@person.errors[:name].any?).to be true
    end

    it 'name should not be too small' do
      @person.name = '12'
      expect(@person.valid?).to be false
      expect(@person.errors[:name].any?).to be true
    end

    it 'has role' do
      @person.role = FactoryBot.create(:role, name: 'test')
      expect(@person.role.name).to eq 'test'
    end

    it 'role can be blank' do
      @person.role = nil
      expect(@person.valid?).to be true
    end

    describe 'should have conditions' do
      it 'active by default' do
        expect(@person.condition).to eq 0
        expect(@person.get_condition).to eq :active
      end

      it 'can be removed' do
        @person.set_condition :removed
        expect(@person.condition).to eq 2
        expect(@person.get_condition).to eq :removed
      end

      it 'can be stoped' do
        @person.set_condition :stoped
        expect(@person.condition).to eq 1
        expect(@person.get_condition).to eq :stoped
      end

      it 'can be active' do
        @person.set_condition :active
        expect(@person.condition).to eq 0
        expect(@person.get_condition).to eq :active
      end
    end

    describe 'should add and update tags' do
      before do
        tags = 'tag 1, tag 2, tag 3'
        @person.tags = tags
        @person.save

        @person.reload
      end

      it 'includes right qty of tags' do
        expect(@person.tags_array.size).to eq 3
      end

      it 'includes right records' do
        expect(@person.tags_array.include?('tag 1')).to be true
        expect(@person.tags_array.include?('tag 2')).to be true
        expect(@person.tags_array.include?('tag 3')).to be true
      end
    end


  end
end