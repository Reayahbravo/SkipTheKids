class RemoveRequestFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_reference :transactions, :request, foreign_key: true
  end
end
