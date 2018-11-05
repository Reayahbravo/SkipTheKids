class AddAdvertisementToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :advertisement, foreign_key: true
  end
end
