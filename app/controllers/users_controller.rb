class UsersController < ApplicationController

def show
  binding.pry
end

def current_user_account
  render json: {user: current_user, nominated_users: current_user.find_nominated_users}, status: :created
end


private

def user_params
  binding.pry
    params.permit(:id, :password)
end


end
