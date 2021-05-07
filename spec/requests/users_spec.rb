require "rails_helper"

RSpec.describe "Users", :type => :request do
  before do
    @user = FactoryBot.create(:user)
    @auth_headers = @user.create_new_auth_token
    sign_in @user
  end

  describe 'get /api/v1/users' do
    before do 
      @user_1 = FactoryBot.create(:user)
      @user_2 = FactoryBot.create(:user)  

      get '/api/v1/users', headers: @auth_headers
      @results = JSON.parse(response.body)
      @result_1 = @results.detect{ |rec| rec['id'] == @user_1._id.to_s }
      @result_2 = @results.detect{ |rec| rec['id'] == @user_2._id.to_s }
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns right qty of records' do
      expect(@results.size).to eq 3
    end

    it 'users has right name field' do
      expect(@result_1['name']).to eq @user_1.name
      expect(@result_2['name']).to eq @user_2.name
    end
  end
end