class User < ApplicationRecord
    has_secure_password

    # has_many :bookings, dependent: :destroy
    has_many :joins, dependent: :destroy
    has_many :children, through: :joins
    has_many :reviews, dependent: :destroy
    has_many :offers, dependent: :destroy
    has_many :requests, dependent: :destroy
    has_many :transactions, dependent: :destroy
    has_many :messages, dependent: :destroy
    # has_many :conversations, :foreign_key => :sender_id
    has_many :book_offers, dependent: :destroy
    has_many :book_requests, dependent: :destroy
    # has_many :reviews, dependent: :nullify
    # has_many :transactions, dependent: :nullify

    accepts_nested_attributes_for :children, reject_if: :all_blank, allow_destroy: true

    validates :first_name, :last_name, :location, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :alias, presence: true, uniqueness: true
  
    validates(
      :email,
      presence: true,
      uniqueness: true,
      format: VALID_EMAIL_REGEX
    )
  
    def full_name
      first_name + " " + last_name
    end
  end
