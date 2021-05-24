class NominationsController < ApplicationController

    def create
        split_handle =  nomination_params[:linkedin_handle].split("/")[-1]
        if current_user.find_co_worker_nominated_users.count.count >= 3 && nomination_params[:co_worker] == true 
            render json: {message: "You have already nominated the maximum number of Current Co-Worker nominations. To add another nomination, you must first remove an existing one."}
        elsif current_user.find_past_co_worker_nominated_users.count.count >= 3 && nomination_params[:co_worker] == false 
            render json: {message: "You have already nominated the maximum number of Past Co-Worker nominations. To add another nomination, you must first remove an existing one."}
        else
            nominated = User.where(linkedin_handle: split_handle).first_or_create do |nominated|
                nominated.linkedin_handle = split_handle
            end
            
            nomination = Nomination.new
            nomination.nominator = current_user
            nomination.nominated = nominated
            nomination.co_worker = nomination_params[:co_worker]
    
            if  !current_user.outbound_nominations.where(nominated_id: nominated.id).empty?
                render json: {message: "Unable to nominate user"}
            else
                # nomination.invite_code = encode_token({nomination_id: nomination.id})
                # JWT.decode("eyJhbGciOiJIUzI1NiJ9.eyJub21pbmF0aW9uX2lkIjo1Mzh9.XyOPlw0L6XCQlUuDKvXofyJ62uKAgyor-syCj68QjHY",ENV['SECRET_KEY_BASE'], true, algorithm: 'HS256')
                nomination.save
                render json: {user: nominated, nomination: nomination}
                NewNominationNotificationMailer.send_notifiaction_email(nominated, JWT.encode({user_invite_id: nominated.id}, ENV['SECRET_KEY_BASE'])).deliver_later
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
