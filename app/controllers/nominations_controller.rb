class NominationsController < ApplicationController

    def create
<<<<<<< HEAD
        nominated = User.where(github_username: nomination_params[:github_username]).first_or_create do |nominated|
            nominated.github_id = nomination_params[:github_id]
            nominated.github_username = nomination_params[:github_username]
            nominated.avatar = nomination_params[:avatar]
            nominated.email = nomination_params[:email]
        end
        
        if nominated.email.blank?
            nominated.update(email: nomination_params[:email])
        end

        nomination = Nomination.new()
        nomination.nominator = current_user
        nomination.nominated = nominated

        if  !current_user.outbound_nominations.where(nominated_id: nominated.id, active: true).empty?
            render json: {message: "Unable to nominate user"}
        elsif nominated.email.blank?
            render json: {message: "Email address required to nominated a user."}
=======
        if current_user.find_co_worker_nominated_users.count.count >= 3 && nomination_params[:co_worker] == true 
            render json: {message: "You have already nominated the maximum number of Current Co-Worker nominations. To add another nomination, you must first remove an existing one."}
        elsif current_user.find_past_co_worker_nominated_users.count.count >= 3 && nomination_params[:co_worker] == false 
            render json: {message: "You have already nominated the maximum number of Past Co-Worker nominations. To add another nomination, you must first remove an existing one."}
>>>>>>> google-auth
        else
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
