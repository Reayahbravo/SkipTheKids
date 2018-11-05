class RemoveChildFromBookOffers < ActiveRecord::Migration[5.2]
  def change
    remove_reference :book_offers, :child, foreign_key: true
  end
end
