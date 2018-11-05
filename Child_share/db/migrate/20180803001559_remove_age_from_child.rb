class RemoveAgeFromChild < ActiveRecord::Migration[5.2]
  def change
    remove_column :children, :age, :integer
  end
end
