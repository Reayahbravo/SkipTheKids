class AddChildCountToBookOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :book_offers, :child_count, :integer
  end
end
