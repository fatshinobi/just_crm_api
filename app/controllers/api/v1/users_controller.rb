class Api::V1::UsersController < Api::V1::ApplicationController
  def index
    users = User.all.pluck(:_id, :name).map{ |rec| {id: rec[0].to_s, name: rec[1]} }
    render json: users, status: :ok
  end
end
