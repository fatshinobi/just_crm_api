class Api::V1::CustomersController < Api::V1::ApplicationController
  def index
    customers = Customer.unremoved.pluck(:_id, :name).map{ |rec| {id: rec[0].to_s, name: rec[1]} }
    render json: customers, status: :ok
  end

  def show
    customer = Customer.find(params[:id])
    render json: CustomerRepresenter.new(customer).as_json, status: :ok
  end

  def create
    customer = Customer.new(name: customer_params[:name], user: current_api_v1_user)

    if customer.save
      render json: CustomerRepresenter.new(customer).as_json, status: :created
    else
      render json: customer.errors, status: :unprocessable_entity
    end
  end

  def update
    customer = Customer.find(params[:id])
    customer.assign_attributes(customer_params)

    if customer.save
      render json: CustomerRepresenter.new(customer).as_json, status: :accepted
    else
      render json: customer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.set_condition(:removed)
    customer.save

    render json: {}, status: :ok
  end

  private

  def customer_params
    params.require(:customer).permit(:id, :name)
  end
end