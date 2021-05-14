class UsersController < ApplicationController

  def show
    if admin?
      user = User.find_by(id: user_params[:id])
      render json: user, include: [:outbound_nominations, :inbound_nominations]
    end
  end
      
  def current_user_account
     render json: UserSerializer.new(current_user).full_user_profile, status: :created
  end


  private

  def user_params
      params.permit(:id)
  end


end
