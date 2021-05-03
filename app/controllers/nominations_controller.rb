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
            # binding.pry
            render json: {message: "Unable to nominate user"}
        elsif nominated.email.blank?
            # binding.pry
            render json: {message: "Email address required to nominated a user."}
        else
            nomination.save
            render json: {user: nominated}
            UserInviteMailer.send_signup_email(nominated,  "#{ENV['DOMAIN']}/nominations/#{nomination.id}/invite").deliver_later
        end
    end
    
    def show
    end

    def update
        nominations = current_user.outbound_nominations.map do |nom|
            nom if nom.nominated.id == nomination_params[:user_id]
        end
        nominations.compact.each do |nom|
            nom.active = false
            nom.save
        end
    end

    private

    def nomination_params 
        params.require(:nomination).permit(:github_username, :avatar, :email, :user_id)
    end

end
