class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.datetime :actual_from
      t.datetime :actual_to
      t.references :user, foreign_key: true
      t.references :offer, foreign_key: true
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
