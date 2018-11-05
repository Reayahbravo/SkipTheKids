class Booking < ApplicationRecord
  belongs_to :offer
  belongs_to :request
  # belongs_to :offer, inverse_of: :requests
  # belongs_to :request, inverse_of: :offers

  validates :offer_id, presence: true
  validates :request_id, presence: true
  validates :isactive, presence: true
  validates :status, presence: true
end
