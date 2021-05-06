class UsersController < ApplicationController

def current_user_account
  render json: {user: current_user, nominated_users: current_user.find_nominated_users, score: current_user.inbound_nominations.where(active: true).count}, status: :created
end


private

def user_params
    params.permit(:id, :password)
end


end
