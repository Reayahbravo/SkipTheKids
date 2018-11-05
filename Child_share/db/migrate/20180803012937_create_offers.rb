class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.datetime :proposed_from
      t.datetime :proposed_to
      t.integer :max_child_number
      t.text :note
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
