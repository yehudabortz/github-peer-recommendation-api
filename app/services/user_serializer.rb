class UserSerializer

    def initialize(user_object)
        @user = user_object
    end

    def base_user_profile_with_jwt
        @user.to_json(:only => [:github_username, :avatar, :jwt_token]) 
    end

    def base_user_profile
        @user.to_json(:only => [:github_username, :avatar]) 
    end
end