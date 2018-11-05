class RenameAdvertisementToBooking < ActiveRecord::Migration[5.2]
  def change
    rename_table :advertisements, :bookings
  end
end
