class Tea < ApplicationRecord
  has_many :tea_subs, :dependent => :destroy
  has_many :subscriptions, through: :tea_subs, :dependent => :destroy

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :temperature
  validates_presence_of :brew_time
end
