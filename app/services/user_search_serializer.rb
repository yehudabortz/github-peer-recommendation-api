class UserSearchSerializer

    def initialize(users)
        @users = users
    end

    def to_serialized_json
        @users.as_json(:include => [:outbound_nominations, :inbound_nominations], :except => [:jwt_token])
    end
end

