class User < ApplicationRecord
  validates :first_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  has_secure_password
  has_many :orders
  has_many :carts

  def is_customer
    role == "customer"
  end

  def is_owner
    role == "owner"
  end

  def is_clerk
    role == "clerk"
  end
end
