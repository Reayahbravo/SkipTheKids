class BookOffer < ApplicationRecord
  belongs_to :user
  # belongs_to :child
  belongs_to :offer

  # validates :book_offer_id, presence: true
  validates :offer_id, presence: true
  validates :user_id, presence: true
  validates :child_count, presence: true
  validates :status, presence: true
  validates :note, presence: true
end
