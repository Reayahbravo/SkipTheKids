class Transaction < ApplicationRecord
  belongs_to :user

  has_one :booking, dependent: :destroy
  

  validates(:actual_from, presence: true)
  validates(:actual_to, presence: true)
  # validates :booking_id, presence: true
  validates :user_id, presence: true
end
