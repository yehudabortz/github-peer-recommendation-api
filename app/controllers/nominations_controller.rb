class NominationsController < ApplicationController

    def create
        nominated = User.where(linkedin_handle: nomination_params[:linkedin_handle]).first_or_create do |nominated|
            nominated.linkedin_handle = nomination_params[:linkedin_handle]
        end
        
        nomination = Nomination.new
        nomination.nominator = current_user
        nomination.nominated = nominated
        nomination.co_worker = nomination_params[:co_worker]

        if  !current_user.outbound_nominations.where(nominated_id: nominated.id).empty?
            render json: {message: "Unable to nominate user"}
        else
            nomination.save
            render json: {user: nominated, nomination: nomination}
            # UserInviteMailer.send_signup_email(nominated,  "#{ENV['DOMAIN']}/nominations/#{nomination.id}/invite").deliver_later
        end
    end
    
    def show
    end

    def update
        if nomination_params[:user_id]
            nominations = current_user.outbound_nominations.map do |nom|
                if !nom.nominated.nil?
                    nom if nom.nominated.id == nomination_params[:user_id]
                end
            end
            nominations.compact.each do |nom|
                nom.active = false
                nom.save
            end
            render json: {message: "Nomination Removed"}
        else
            render json: {message: "Unable to remove nomination."}
        end
    end

    private

    def nomination_params 
        params.require(:nomination).permit(:linkedin_handle, :co_worker, :user_id)
    end

end
