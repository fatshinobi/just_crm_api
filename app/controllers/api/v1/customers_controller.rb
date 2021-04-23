class Api::V1::CustomersController < Api::V1::ApplicationController
  def index
    customers = Customer.pluck(:_id, :name).map{ |rec| {id: rec[0].to_s, name: rec[1]} }
    render json: customers, status: :ok
  end

  def create
    customer = Customer.new(name: customer_params[:name], user: current_api_v1_user)

    if customer.save
      render json: { 
        id: customer._id.to_s, 
        name: customer.name
      }, status: :created
    else
      render json: customer.errors, status: :unprocessable_entity
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:id, :name)
  end
end