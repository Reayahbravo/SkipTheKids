class RemoveUserFromChildren < ActiveRecord::Migration[5.2]
  def change
    remove_reference :children, :user, foreign_key: true
  end
end
