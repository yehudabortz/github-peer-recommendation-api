class NominationsController < ApplicationController

    def create
        nominated = User.where(github_username: nomination_params[:github_username]).first_or_create do |nominated|
            nominated.github_username = nomination_params[:github_username]
            nominated.avatar = nomination_params[:avatar]
            nominated.email = nomination_params[:email]
        end
        nomination = Nomination.new()
        nomination.nominator = current_user
        nomination.nominated = nominated
        if  !current_user.outbound_nominations.where(nominated_id: nominated.id).empty?
            render json: {message: "Unable to nominate user"}
        else
            nomination.save
            render json: {user: nominated}
        end
    end
    
    def show
    end

    def update
    end

    private

    def nomination_params 
        params.require(:nomination).permit(:github_username, :avatar, :email)
    end
end
