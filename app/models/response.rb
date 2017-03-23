class Response < ActiveRecord::Base
  MESSAGES = [
    "Okay!",
    "I can do that.",
    "I can not do that, can you contact me?",
    "I will do that.",
    "I will get this done as soon as possible!",
    "Sorry, I can't get to this right now, can you contact another team member?",
    "Sorry, I can't get to this today, can you contact another team member?",
    "There is an issue, can you contact me?",
    "I'm confused about this, can you contact me?"
  ]

  belongs_to :account
  belongs_to :order

  enum message: MESSAGES

  validates :message, presence: true
end
