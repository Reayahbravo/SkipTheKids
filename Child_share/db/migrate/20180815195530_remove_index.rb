class RemoveIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :transactions, name: "index_transactions_on_advertisement_id"
  end
end
