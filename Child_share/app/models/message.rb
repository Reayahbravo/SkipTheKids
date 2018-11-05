class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id
  validates_presence_of :conversation_id, presence: true
  validates_presence_of :user_id, presence: true
  
  # def message_time
  #  created_at.strftime(“%m/%d/%y at %l:%M %p”)
  # end
 end
