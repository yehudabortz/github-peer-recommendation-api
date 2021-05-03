class CreateNominations < ActiveRecord::Migration[6.1]
  def change
    create_table :nominations do |t|
      t.references :nominator
      t.references :nominated
      t.boolean :accepted, :default => false
      t.boolean :co_worker
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
