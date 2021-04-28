class GithubAuthController < ApplicationController

  def github_callback      
    redirect_uri = 'http://localhost:4000/auth/github_oauth2/callback'
    response = HTTParty.get("https://github.com/login/oauth/access_token?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=#{redirect_uri}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}&code=#{github_params[:code]}")
    token = response.split('access_token=')[1].split('&scope')[0]
    create_user_from_github(token)
  end

  def create_user_from_github(token)
    client = Octokit::Client.new(:access_token => token)
    if User.find_by(github_username: client.user.login)
        render :json { error: "Unable to login"}
    else
        user = User.create(github_username: client.user.login, avatar: client.user.avatar_url)
        render :json {user}
    end
    # binding.pry
  end
end

private

def github_params
    params.permit(:code)
end

# THIS LINK IN THE BROWSER DOWNLOADS THE USER TOKEN
# https://github.com/login/oauth/access_token?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=http://localhost:4000/auth/github_oauth2/callback&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}&code=#{params[:code]}