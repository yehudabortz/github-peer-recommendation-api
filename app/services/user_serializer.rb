class UserSerializer

    def initialize(user_object)
        @user = user_object
    end

    def base_user_profile_with_jwt
        @user.to_json(:include => {
            :outbound_nominations => {}
            }
        ) 
    end

    def base_user_profile
        # @user.to_json(:only => [:github_username, :avatar]) 
        # nominated_users = (current_user)
        # @user.to_json(:include => {
        #     :nominated_users => {name:"yehuda"}
        #     }
        # ) 
            @user.to_json(:include => {
            :outbound_nominations => {:include => { name:"yehuda"}}
            }
        ) 
    end
end