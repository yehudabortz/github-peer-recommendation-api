class GoogleAuthController < ApplicationController
    skip_before_action :authorized


    def google_callback   
        url = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{google_params[:id_token]}"                  
        response = HTTParty.get(url)    
        if google_params["invite_token"] != ""
            create_user_from_google(response)
        elsif response["email"] == ENV['FROM_EMAIL_ADDRESS']
            create_app_admin_from_google(response)
        else
            login_user_from_google(response)
        end
    end
    
    def create_user_from_google(response)
        if response["aud"] == ENV['GOOGLE_CLIENT_ID']
            decoded_token = JWT.decode(google_params[:invite_token],ENV['SECRET_KEY_BASE'], true, algorithm: 'HS256')
            user = User.find_by(id: decoded_token[0]["user_invite_id"])
            if (user.email.nil? && !User.find_by(email: response["email"]))
                user.update(
                    name: response["name"],
                    email: response["email"],
                    avatar: response["picture"],
                    jwt_token: encode_token({user_id: user.id})
                )
                if decoded_token[0]["outbound_invite_id"]
                    invite = Invite.find_by(id: decoded_token[0]["outbound_invite_id"])
                    user.inbound_invites << invite
                    user.save
                end
                user.jwt_token = encode_token({user_id: user.id})
                render json: UserSerializer.new(user).full_user_profile, status: :created
            else
                render json: {message: "Invite Token Expired"}
            end
        else
            render json: {message: "Unable to login"}
        end
    end

    def login_user_from_google(response)
        if response["aud"] == ENV['GOOGLE_CLIENT_ID']
            # user = User.find_by(email: response["email"], provider: "google")
            user = User.where(email: response["email"], provider: "google").first_or_create do |user|
                user.name = response["name"]
                user.email = response["email"]
                user.avatar = response["picture"]
                user.jwt_token = encode_token({user_id: user.id})
                user.admin = true
                user.work_preference = WorkPreference.create
            end
            user.jwt_token = encode_token({user_id: user.id})
            render json: UserSerializer.new(user).full_user_profile, status: :created
        else
            render json: {message: "Unable to login"}
        end
    end

    def create_app_admin_from_google(response)
        if response["aud"] == ENV['GOOGLE_CLIENT_ID'] && response["email"] == ENV['FROM_EMAIL_ADDRESS']
            user = User.where(email: response["email"], provider: "google").first_or_create do |user|
                user.name = response["name"]
                user.email = response["email"]
                user.avatar = response["picture"]
                user.jwt_token = encode_token({user_id: user.id})
                user.admin = true
                user.work_preference = WorkPreference.create
            end
            user.jwt_token = encode_token({user_id: user.id})
            render json: UserSerializer.new(user).full_user_profile, status: :created
        else
            render json: {message: "Unable to login"}
        end
    end

    private
    def google_params
        params.require(:google_auth).permit(:access_token, :id_token, :invite_token)
    end
end
