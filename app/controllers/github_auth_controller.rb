class GithubAuthController < ApplicationController

  def github_callback      
      response = HTTParty.get("https://github.com/login/oauth/access_token?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=http://localhost:4000/auth/github_oauth2/callback&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}&code=#{params[:code]}")

    #   Should fetch user data
    #   user = HTTParty.get('https://github.com/api/v2/json/user/show?${response}')
      binding.pry
  end
end

# THIS LINK IN THE BROWSER DOWNLOADS THE USER TOKEN
# https://github.com/login/oauth/access_token?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=http://localhost:4000/auth/github_oauth2/callback&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}&code=#{params[:code]}