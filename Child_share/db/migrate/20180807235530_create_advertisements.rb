class CreateAdvertisements < ActiveRecord::Migration[5.2]
  def change
    create_table :advertisements do |t|
      t.boolean :is_active
      t.string :status
      t.references :offer, foreign_key: true
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
