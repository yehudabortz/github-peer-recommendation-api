class AddOpenToWorkToWorkPreference < ActiveRecord::Migration[6.1]
  def change
    add_column :work_preferences, :open_to_work, :boolean
  end
end
