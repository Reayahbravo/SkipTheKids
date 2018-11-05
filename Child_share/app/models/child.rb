class Child < ApplicationRecord
  belongs_to :user
  has_many :users, through: :joins
  has_many :book_offers, dependent: :destroy
  has_many :book_requests, dependent: :destroy

    validates :user_id, presence: true
    validates :first_name, :last_name, :birthdate, presence: true
  
  end
