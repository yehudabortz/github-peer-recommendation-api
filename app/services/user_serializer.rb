class UserSerializer

    def initialize(user_object)
        @user = user_object

    end

    def base_user_json
        @user.to_json(:only => [:github_username, :avatar, :jwt_token]) 
    end
end