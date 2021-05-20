class UserSearchSerializer

    def initialize(users)
        @users = users
    end

    def to_serialized_json
        @users.as_json(:include => [:outbound_nominations, :inbound_nominations, :work_preference], :except => [:jwt_token])
    end
end

