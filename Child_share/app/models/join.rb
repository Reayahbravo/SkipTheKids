class Join < ApplicationRecord
  belongs_to :user
  belongs_to :child

  validates :user_id, uniqueness: { scope: :join_id }
end
