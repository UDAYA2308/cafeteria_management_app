class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  def self.pending_order
    all.where(delivered_at: nil)
  end
end
