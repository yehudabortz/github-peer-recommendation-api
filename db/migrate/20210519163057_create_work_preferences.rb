class CreateWorkPreferences < ActiveRecord::Migration[6.1]
  def change
    create_table :work_preferences do |t|
      t.boolean :willing_to_relocate
      t.boolean :open_to_remote_work
      t.boolean :open_to_local_work
      t.integer :current_zip_code
      t.integer :max_commute_time
      t.boolean :open_to_targeted_jobs
      t.boolean :open_to_new_company
      t.boolean :open_to_new_role_at_current
      t.integer :user_id

      t.timestamps
    end
  end
end
