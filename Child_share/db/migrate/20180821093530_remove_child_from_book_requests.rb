class RemoveChildFromBookRequests < ActiveRecord::Migration[5.2]
  def change
    remove_reference :book_requests, :child, foreign_key: true
  end
end
