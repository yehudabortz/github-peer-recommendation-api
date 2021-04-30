class GithubSearchController < ApplicationController

    def search_users

        response = HTTParty.get("https://api.github.com/search/users?q=#{search_params[:q]}")
        users = response["items"][0..10]
        render :json => { users: users }
    end

    private 

    def search_params
        params.permit(:q)
    end
end
