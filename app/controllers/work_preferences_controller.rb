class WorkPreferencesController < ApplicationController
    def update
        work_pref_params["preferenceObj"].each do |key, value|
            if key === "open_to_work" && value == false
                current_user.work_preference.update("#{key}"=> value, open_to_local_work: false,
                open_to_local_work: false, open_to_remote_work: false, willing_to_relocate: false,
                open_to_targeted_jobs: false, open_to_new_company: false, open_to_new_role_at_current: false)
            else
                current_user.work_preference.update("#{key}"=> value)
            end

        end
        # binding.pry
        render json: {message: "Preferences Updated", work_preference: current_user.work_preference}
    end

    private
    def work_pref_params
        params.require(:work_preference).permit(preferenceObj: [:open_to_work, :open_to_local_work, :open_to_remote_work, :willing_to_relocate, :current_zip_code, :open_to_targeted_jobs, :open_to_new_company, :open_to_new_role_at_current])
    end
end
