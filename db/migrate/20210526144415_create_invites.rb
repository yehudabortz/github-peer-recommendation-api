class CreateInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :invites do |t|
      t.string :invite_token
      
      t.references :inviter
      t.references :invited
      t.timestamps
    end
  end
end
