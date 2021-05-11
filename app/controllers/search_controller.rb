class SearchController < ApplicationController
  def search_index
    if admin?
      page = search_params[:page].to_i
      display_count = search_params[:display_count]
      offset = page * display_count.to_i
      results_count = User.all.count

      if search_params[:filter] #&& search_params[:condition]
        binding.pry

        
        # ITERATE THROUGH AND QUERY BASED ON EACH KEY VALUE
        filter_keys = search_params[:filter].keys
        filter_keys.map do |key|
            puts "#{key} #{search_params[:filter].values_at(key)}"
             search_params[:filter].values_at(key)
        end

        results_count = User.where("#{search_params[:filter]}": "#{search_params[:condition]}").count
        users = User.where("#{search_params[:filter]}": "#{search_params[:condition]}").offset(offset).limit(display_count).reverse_order
      else
        users = User.offset(offset).limit(display_count).reverse_order
      end
      render :json => {users: UserSearchSerializer.new(users).to_serialized_json, results_count: ResultsCountSerializer.new(results_count).to_serialized_json }
    end
  end

  def show
    if admin?
      user = User.find_by(id: search_params[:id])
      render json: user, include: [:outbound_nominations, :inbound_nominations]
    end
  end
      


  private

  def search_params
      params.require(:search).permit(:id,:page,:display_count, filter: [:open_to_work, :inbound_nominations])
  end

end
