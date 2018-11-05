class CreateBookOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :book_offers do |t|
      t.string :status
      t.text :note
      t.references :user, foreign_key: true
      t.references :child, foreign_key: true
      t.references :offer, foreign_key: true

      t.timestamps
    end
  end
end
