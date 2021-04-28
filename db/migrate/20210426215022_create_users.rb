class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :github_username
      t.string :avatar
      t.string :email
      t.string :jwt_token
      t.boolean :admin, :default => false
      t.integer :score

      t.timestamps
    end
  end
end
