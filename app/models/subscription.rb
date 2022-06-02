class Subscription < ApplicationRecord
  belongs_to :customer

  has_many :tea_subs
  has_many :teas, through: :tea_subs

  validates_presence_of :title,
                       :price,
                       :status,
                       :frequency

end
