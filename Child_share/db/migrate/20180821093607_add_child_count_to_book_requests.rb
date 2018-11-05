class AddChildCountToBookRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :book_requests, :child_count, :integer
  end
end
