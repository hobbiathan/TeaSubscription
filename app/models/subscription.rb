class Subscription < ApplicationRecord
  belongs_to :customer

  has_many :tea_subs, :dependent => :destroy
  has_many :teas, through: :tea_subs, :dependent => :destroy

  validates_presence_of :title,
                       :price,
                       :status,
                       :frequency

  attribute :status, default: 0

  enum status: { active: 0, inactive: 1 }
  enum frequency: { weekly: 0, bi_weekly: 1, monthly: 2 }

end
