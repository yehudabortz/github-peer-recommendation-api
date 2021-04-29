class UsersController < ApplicationController

def show
  binding.pry
end

def current_user_account
  render json: UserSerializer.new(current_user).base_user_profile, status: :created
end


private

def user_params
  binding.pry
    params.permit(:id, :password)
end


end
