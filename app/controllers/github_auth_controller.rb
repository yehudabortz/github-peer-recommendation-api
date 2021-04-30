class GithubAuthController < ApplicationController
    skip_before_action :authorized

    def github_callback    

      response = HTTParty.get("https://github.com/login/oauth/access_token?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=#{ENV['REDIRECT_URI']}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}&code=#{github_params[:code]}")
    #   binding.pry
      token = response.split('access_token=')[1].split('&scope')[0]
      create_user_from_github(token)
    end

    def create_user_from_github(token)
      client = Octokit::Client.new(:access_token => token)
      user = User.find_by(github_username: client.user.login)
        if user
            user.jwt_token = encode_token({user_id: user.id})
            render json: UserSerializer.new(user).base_user_profile_with_jwt, status: :created
        else
            user = User.create(github_username: client.user.login, avatar: client.user.avatar_url)
            user.jwt_token = encode_token({user_id: user.id})
            render json: UserSerializer.new(user).base_user_profile_with_jwt, status: :created
        end
    end


    private
    
    def github_params
        params.require(:github_auth).permit(:code)
    end
end


# THIS LINK IN THE BROWSER DOWNLOADS THE USER TOKEN
# https://github.com/login/oauth/access_token?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=http://localhost:4000/auth/github_oauth2/callback&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}&code=#{params[:code]}