class Order < ActiveRecord::Base
  STATES = [
    "available",
    "finished",
    "canceled"
  ]
  PRIORITIES = [
    "normal",
    "urgent"
  ]
  SUBTYPES = [
    "generic",
    "user_change",
    "user_refund",
    "designer_change",
    "designer_remove",
    "project_change",
    "project_pause",
    "submission_change",
    "revision_remove",
    "firstlook_remove"
  ]

  belongs_to :requester, class_name: "Account"
  belongs_to :owner, class_name: "Account"
  has_many :responses

  scope :available, -> { where(state: :available) }
  scope :finished, -> { where(state: :finished) }
  scope :canceled, -> { where(state: :canceled) }
  scope :chronological, -> { order(created_at: :desc) }
  scope :created_on, ->(timestamp) { where(created_at: (timestamp..timestamp.end_of_day))}

  enum priority: PRIORITIES
  enum subtype: SUBTYPES

  validates :description, presence: true
  validates :state, presence: true, inclusion: {in: STATES}
  validates :priority, presence: true
  validates :subtype, presence: true

  state_machine :state, initial: :available do
    event :finish do
      transition :available => :finished
    end

    event :cancel do
      transition :available => :canceled
    end

    after_transition to: :finished do |order|
      order.finished_at = Time.now
    end

    after_transition to: :canceled do |order|
      order.canceled_at = Time.now
    end
  end
end
