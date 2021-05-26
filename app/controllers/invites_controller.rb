class InvitesController < ApplicationController

    def create
        invite = Invite.new
        linkedin_handle = User.split_linkedin_handle(invite_params["linkedin_handle"])
        user = User.find_by(linkedin_handle: linkedin_handle)
        if user
            render json: {message: "User cannot be invited."}
        else
            invited_user = User.new(linkedin_handle: linkedin_handle)
            invited_user.inbound_invites << invite
            current_user.outbound_invites << invite
            current_user.save
            invited_user.save
            outbound_invite_token = JWT.encode({user_invite_id: invited_user.id,outbound_invite_id: invite.id}, ENV['SECRET_KEY_BASE'])
            render json: {outbound_invite_token: outbound_invite_token, remaining_invites: (10 - current_user.outbound_invites.count)}
        end 

    end
    private

    def invite_params
       params.require(:invite_object).permit(:linkedin_handle)
    end
end
