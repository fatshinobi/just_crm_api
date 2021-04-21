require "rails_helper"

RSpec.describe "Customers", :type => :request do
  before do
    FactoryBot.create_list(:customer, 10)
  end

  describe '/api/v1/customers' do
    before { get '/api/v1/customers' }

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns right qty of records' do
      puts JSON.pretty_generate(JSON.parse(response.body)['results'])
      expect(JSON.parse(response.body)['results'].size).to eq 10
    end
  end
end