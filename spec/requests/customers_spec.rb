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

    it 'returns right record' do
      expect(JSON.parse(response.body)).to eq ({
        'id' => @customer.id.to_s,
        'name' => 'test 1',
        'about' => @customer.about,
        'phone' => @customer.phone,
        'web' => @customer.web,
        'user_id' => @customer.user.id.to_s
      })
    end
  end

  describe 'post /api/v1/customers' do
    before do
      @curator = FactoryBot.create(:user)
      post '/api/v1/customers', params: { customer: {name: 'test name 1', about: 'test about', phone: 'test phone', web: 'test.com', user_id: @curator.id} }, headers: @auth_headers
      @customer = Customer.first
    end

    it 'returns created' do
      expect(response).to have_http_status(:created)
    end

    it 'creates right record' do
      expect(@customer.name).to eq 'test name 1'
    end

    it 'returns right record' do
      expect(JSON.parse(response.body)).to eq ({
        'id' => @customer.id.to_s,
        'name' => 'test name 1',
        'about' => 'test about',
        'phone' => 'test phone',
        'web' => 'test.com',
        'user_id' => @curator.id.to_s
      })
    end

  end

  describe 'patch /api/v1/customers' do
    before do
      @curator = FactoryBot.create(:user)
      @customer = FactoryBot.create(:customer, name: 'test 1')
      patch "/api/v1/customers/#{@customer._id.to_s}", params: { customer: {name: 'test 2', about: 'test about', phone: 'test phone', web: 'test.com', user_id: @curator.id} }, headers: @auth_headers
    end

    it 'returns created' do
      expect(response).to have_http_status(:accepted)
    end

    it 'creates right record' do
      @customer.reload
      expect(@customer.name).to eq 'test 2'
    end

    it 'returns right record' do
      expect(JSON.parse(response.body)).to eq ({
        'id' => @customer.id.to_s,
        'name' => 'test 2',
        'about' => 'test about',
        'phone' => 'test phone',
        'web' => 'test.com',
        'user_id' => @curator.id.to_s
      })
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