class BookRequest < ApplicationRecord
  belongs_to :user
  # belongs_to :child
  belongs_to :request


  validates :book_request_id, presence: true
  validates :request_id, presence: true
  validates :user_id, presence: true
  validates :child_count, presence: true
  validates :status, presence: true#, if: :paid_with_card?
  validates :note, presence: true
end
