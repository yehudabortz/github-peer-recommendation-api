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

    def full_user_profile
        {user: @user, nominated_users: @user.find_nominated_users, co_worker_nominated_users: @user.find_co_worker_nominated_users, past_co_worker_nominated_users: @user.find_past_co_worker_nominated_users, score: @user.inbound_nominations.count, work_preferences: @user.work_preference}
    end
end