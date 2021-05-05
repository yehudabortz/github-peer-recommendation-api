class GithubSearchController < ApplicationController

    def search_users

        # response = HTTParty.get("https://api.github.com/search/users?q=#{search_params[:q]}")
        # binding.pry
        # response = HTTParty.get("https://api.github.com/users/#{search_params[:q]}")
        # response = HTTParty.get("https://api.github.com/users/#{search_params[:q]}?client_id=#{ENV['GITHUB_CLIENT_ID']}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}")

        response = HTTParty.get("https://api.github.com/users/#{search_params[:q]}", 
            headers: {
                Authorization: "token #{ENV['GITHUB_ACCESS_TOKEN']}"
            }
        )
                # GITHUB SEARCH API
        # response = HTTParty.get("https://api.github.com/search/users?q=#{search_params[:q]}", 
        #     headers: {
        #         Authorization: "token #{ENV['GITHUB_ACCESS_TOKEN']}"
        #     }
        # )
        # users = response["items"][0..10]
        render :json => { user: response }
        # render :json => { users: users }

        # client = Octokit::Client.new(:access_token => ENV['GITHUB_CLIENT_SECRET'])
    end

    private 

    def search_params
        params.permit(:q)
    end
end
