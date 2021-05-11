class UsersController < ApplicationController
  def index
    if admin?
      page = user_params[:page].to_i
      display_count = user_params[:display_count]
      offset = page * display_count.to_i
      results_count = User.all.count
      if user_params[:filter] && user_params[:condition]
        results_count = User.where("#{user_params[:filter]}": "#{user_params[:condition]}").count
        users = User.where("#{user_params[:filter]}": "#{user_params[:condition]}").offset(offset).limit(display_count).reverse_order
      else
        users = User.offset(offset).limit(display_count).reverse_order
      end
      render :json => {users: UserSearchSerializer.new(users).to_serialized_json, results_count: ResultsCountSerializer.new(results_count).to_serialized_json }
    end
  end
    
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
      params.permit(:id, :password, :page, :filter, :condition, :display_count)
  end


end
