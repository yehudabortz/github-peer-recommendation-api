class WorkPreferencesController < ApplicationController
    def update
        work_pref_params["preferenceObj"].each do |key, value|
            current_user.work_preference.update("#{key}"=> value)
        end
        render json: {message: "Preferences Updated", work_preference: work_pref_params["preferenceObj"]}
    end

    private
    def work_pref_params
        params.require(:work_preference).permit(preferenceObj: [:open_to_local_work, :open_to_remote_work, :willing_to_relocate, :current_zip_code])
    end
end