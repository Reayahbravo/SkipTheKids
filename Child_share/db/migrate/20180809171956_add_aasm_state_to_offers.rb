class AddAasmStateToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :aasm_state, :string
  end
end
