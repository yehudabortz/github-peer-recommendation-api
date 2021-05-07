class UsersController < ApplicationController
  def index
      if admin?
          users = User.all
          render json: users, include: [:outbound_nominations, :inbound_nominations]
      end
  end
  
  def current_user_account
    render json: {user: current_user, nominated_users: current_user.find_nominated_users, score: current_user.inbound_nominations.count}, status: :created
  end


  private

  def user_params
      params.permit(:id, :password)
  end


end
