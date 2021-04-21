class Api::V1::CustomersController < Api::V1::ApplicationController
  def index
    customers = Customer.all
    render json: customers, status: :ok
    #render json: {results: customers}.to_json, status: :ok
  end
end