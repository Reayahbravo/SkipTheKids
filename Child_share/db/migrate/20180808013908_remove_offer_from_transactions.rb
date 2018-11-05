class RemoveOfferFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_reference :transactions, :offer, foreign_key: true
  end
end
