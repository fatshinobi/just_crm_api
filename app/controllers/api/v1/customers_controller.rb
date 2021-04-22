class Api::V1::CustomersController < Api::V1::ApplicationController
  def index
    customers = Customer.pluck(:_id, :name).map{ |rec| {id: rec[0].to_s, name: rec[1]} }
    render json: customers, status: :ok
    #render json: {results: customers}.to_json, status: :ok
  end
end