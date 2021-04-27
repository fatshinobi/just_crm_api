require "rails_helper"

RSpec.describe "Customers", :type => :request do
  before do
    @user = FactoryBot.create(:user)
    @auth_headers = @user.create_new_auth_token
    sign_in @user
  end

  describe 'get /api/v1/customers' do
    before do 
      FactoryBot.create_list(:customer, 2)
      get '/api/v1/customers', headers: @auth_headers
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns right qty of records' do
      expect(JSON.parse(response.body).size).to eq 2
    end
  end

  describe 'get /api/v1/customers/id' do
    before do 
      @customer = FactoryBot.create(:customer, name: 'test 1')
      get "/api/v1/customers/#{@customer.id}", headers: @auth_headers
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns right qty of records' do
      expect(JSON.parse(response.body)['name']).to eq 'test 1'
    end
  end

  describe 'post /api/v1/customers' do
    before do
      post '/api/v1/customers', params: { customer: {name: 'test name 1'} }, headers: @auth_headers
    end

    it 'returns created' do
      expect(response).to have_http_status(:created)
    end

    it 'creates right record' do
      customer = Customer.first
      expect(customer.name).to eq 'test name 1'
    end
  end

  describe 'patch /api/v1/customers' do
    before do
      @customer = FactoryBot.create(:customer, name: 'test 1')
      patch "/api/v1/customers/#{@customer._id.to_s}", params: { customer: {name: 'test 2'} }, headers: @auth_headers
    end

    it 'returns created' do
      expect(response).to have_http_status(:accepted)
    end

    it 'creates right record' do
      @customer.reload
      expect(@customer.name).to eq 'test 2'
    end
  end

  describe 'delete /api/v1/customers/id' do
    before do 
      @customer = FactoryBot.create(:customer, name: 'test 1', condition: Conditionable::CONDITIONS_LIST.index(:active))
      delete "/api/v1/customers/#{@customer.id}", headers: @auth_headers
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns right qty of records' do
      @customer.reload
      expect(@customer.condition).to eq Conditionable::CONDITIONS_LIST.index(:removed)
    end
  end

end