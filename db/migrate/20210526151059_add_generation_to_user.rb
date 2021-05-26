class AddGenerationToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :generation, :integer
  end
end
