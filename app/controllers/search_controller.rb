class SearchController < ApplicationController
  def search_index
    if admin?
    users = []
      page = search_params[:page].to_i
      display_count = search_params[:display_count]
      offset = page * display_count.to_i
      results_count = User.all.count

      if search_params[:filter].values.any?  #&& search_params[:condition]
        # ITERATE THROUGH AND QUERY BASED ON EACH KEY VALUE
        filters = search_params[:filter].compact
        filter_keys = filters.keys
        filter_keys.each do |key|
            value = search_params[:filter].values_at(key)[0]
            case filter_keys.count
            when 1
                case key
                when "open_to_work"
                    results_count = User.where("#{key}" => "#{value}").offset(offset).limit(display_count).count
                    users = User.where("#{key}" => "#{value}").offset(offset).limit(display_count).reverse_order
                    break
                when "inbound_nominations"
                    results_count = User.find_most_inbound_nominations.count.count
                    users = User.find_most_inbound_nominations.offset(offset).limit(display_count)
                    break
                    # binding.pry
                end
            when 2
                case key
                when "open_to_work" || "inbound_nominations"
                    results_count =  User.find_most_inbound_nominations.where("#{key}" => "#{value}").offset(offset).limit(display_count).count.count
                    users = User.find_most_inbound_nominations.where("#{key}" => "#{value}").offset(offset).limit(display_count)
                    break
                end
            end
        end
        # users = User.where(open_to_work: true).offset(offset).limit(display_count).reverse_order
        # Order name ABC
        # User.order('name ASC')
        # results_count = User.where("#{search_params[:filter]}": "#{search_params[:condition]}").count
        # users = User.where("#{search_params[:filter]}": "#{search_params[:condition]}").offset(offset).limit(display_count).reverse_order
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


# FINDS USERS WHERE THEIR OUTBOUND NOMINATIONS ARE ACCEPTED
# User.joins(:outbound_nominations).where(:outbound_nominations => { :accepted => true })

# FINDS NOMINATIONS WHERE THE NAME IS X
# Nomination.joins(:nominator).where(:nominator => {name: "Example name"})