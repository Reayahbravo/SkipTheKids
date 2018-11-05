class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.datetime :proposed_from
      t.datetime :proposed_to
      t.integer :child_number
      t.text :note
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
