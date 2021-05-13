class GoogleAuthController < ApplicationController
    skip_before_action :authorized

    def google_callback   
        url = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{google_params[:id_token]}"                  
        response = HTTParty.get(url)      
        create_user_from_google(response)
    end
    
    def create_user_from_google(response)
        if response["aud"] == ENV['GOOGLE_CLIENT_ID']
            user = User.where(email: response["email"], provider: "google").first_or_create do |user|
                user.name = response["name"]
                user.email = response["email"]
                user.avatar = response["picture"]
                user.jwt_token = encode_token({user_id: user.id})
            end
            user.jwt_token = encode_token({user_id: user.id})
            render json: {user: user}
        else
            render json: {message: "Unable to login"}
        end
    end

    private
    def google_params
        params.require(:google_auth).permit(:access_token, :id_token)
    end
end
