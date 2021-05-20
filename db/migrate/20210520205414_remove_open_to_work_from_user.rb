class RemoveOpenToWorkFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :open_to_work
  end
end
