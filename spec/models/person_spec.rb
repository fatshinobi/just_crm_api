require "rails_helper"

RSpec.describe "Person", :type => :model do
  context 'when new person is created' do
    before do
      @person = FactoryBot.build(:person)
    end
  end
end