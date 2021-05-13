class AddOpenToWorkToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :open_to_work, :boolean, default: false
  end
end
