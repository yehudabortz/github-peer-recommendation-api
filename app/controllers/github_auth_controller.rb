class GithubAuthController < ApplicationController
    skip_before_action :authorized

    def github_callback   
        response = HTTParty.get("https://github.com/login/oauth/access_token?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=#{ENV['REDIRECT_URI']}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}&code=#{github_params[:code]}")
        token = response.split('access_token=')[1].split('&scope')[0]
        create_user_from_github(token)
    end
    
    def create_user_from_github(token)
        client = Octokit::Client.new(:access_token => token)
        @user = User.find_by(github_username: client.user.login)
        if @user
            if github_params[:nomination_id]
                if check_invitation?
                    @user.jwt_token = encode_token({user_id: @user.id})
                    render json: {user: @user, nominated_users: @user.find_nominated_users}, status: :created
                else
                    render json: {message: "Nomination expired"}
                end
            else
                @user.jwt_token = encode_token({user_id: @user.id})
                render json: {user: @user, nominated_users: @user.find_nominated_users}, status: :created
            end
        else
            @user = User.create(github_username: client.user.login, avatar: client.user.avatar_url, github_id: client.user.id)
            @user.jwt_token = encode_token({user_id: @user.id})
            render json: {user: @user, nominated_users: @user.find_nominated_users}, status: :created
        end
    end


    private
    
    def github_params
        params.require(:github_auth).permit(:code, :nomination_id)
    end

    def check_invitation?
            nomination = Nomination.find_by(id: github_params[:nomination_id])
            if nomination.nominated.github_id == @user.github_id && !nomination.accepted
                nomination.accepted = true
                nomination.save
                true
            else
                false
            end
    end
end


# THIS LINK IN THE BROWSER DOWNLOADS THE USER TOKEN
# https://github.com/login/oauth/access_token?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=http://localhost:4000/auth/github_oauth2/callback&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}&code=#{params[:code]}