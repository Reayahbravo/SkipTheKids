class AddAasmStateToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :aasm_state, :string
  end
end
