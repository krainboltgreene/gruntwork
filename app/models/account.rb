class Account < ActiveRecord::Base
  devise :database_authenticatable
  devise :registerable
  devise :rememberable
  devise :validatable
  devise :confirmable

  has_many :requests, foreign_key: :requester_id, class_name: "Order"
  has_many :ownerships, foreign_key: :owner_id, class_name: "Order"
  has_many :responses

  scope :watchers, -> { where(watching: true) }

  validates_presence_of :email

  def name
    email.split("@").first
  end
end
