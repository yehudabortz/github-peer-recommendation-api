class UsersController < ApplicationController

  def show
    if admin?
      user = User.find_by(id: user_params[:id])
      render json: user, include: [:outbound_nominations, :inbound_nominations]
    end
  end
      
  def current_user_account
    render json: {user: current_user, nominated_users: current_user.find_nominated_users, score: current_user.inbound_nominations.count}, status: :created
  end


  private

  def user_params
      params.permit(:id, :password, :page, :filter, :display_count)
  end


end
