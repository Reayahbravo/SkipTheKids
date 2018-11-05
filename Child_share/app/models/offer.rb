class Offer < ApplicationRecord
  belongs_to :user
  
  has_many :bookings, dependent: :destroy
  has_many :requests, through: :bookings
  has_many :book_offers, dependent: :destroy

  validates(:proposed_from, presence: true)
  validates(:proposed_to, presence: true)
  validates(:max_child_number, presence: true)
  validates(:note, presence: true)
  validates :user_id, presence: true

  include AASM
  aasm whiny_transitions: false do
    state :posted, initial: true
    state :partially_booked
    state :fully_booked
    state :completed
    state :cancelled

    event :partially_booked do
      transitions from: :posted, to: :partially_booked
    end
  
    event :fully_booked do
      transitions from: [:posted, :partially_booked], to: :fully_booked
    end
  
    event :completed do
      transitions from: [:posted, :partially_booked, :fully_booked], to: :completed
    end
  
    event :cancelled do
      transitions from: [:posted, :partially_booked, :fully_booked], to: :cancelled
    end
  end

  def self.viewable
    where(aasm_state: [:posted, :partially_booked, :fully_booked])
  end
end

