class UserSerializer

    def initialize(user_object)
        @user = user_object
        @invite_token = JWT.encode({user_invite_id: @user.id}, ENV['SECRET_KEY_BASE'])
    end

    def full_user_profile
        check_for_user_settings
        {user: @user, nominated_users: @user.find_nominated_users,
            co_worker_nominated_users: @user.find_co_worker_nominated_users,
            past_co_worker_nominated_users: @user.find_past_co_worker_nominated_users,
            inbound_nominations: @user.inbound_nominations,
            score: @user.inbound_nominations.count,
            invite_token: @invite_token,
            work_preference: @user.work_preference}

    end

    private
    def check_for_user_settings
         if @user.work_preference.nil?
            @user.create_work_preference
        end
    end

end