class AddLinkedInHandleToInvite < ActiveRecord::Migration[6.1]
  def change
    add_column :invites, :linkedin_handle, :string
  end
end
