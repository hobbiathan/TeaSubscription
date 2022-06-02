class Customer < ApplicationRecord
  has_many :subscriptions

  validates_presence_of :first_name,
                        :last_name,
                        :address,
                        :email

  validates_uniqueness_of :email

end
