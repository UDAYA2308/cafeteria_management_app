class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  def self.pending_order
    all.where(delivered_at: nil)
  end

  def self.get_report(from, to, user_id)
    if user_id != ""
      return Order.where("date > ? and date < ? and user_id = ? ", from, to, user_id)
    end
    Order.where("date > ? and date < ? ", from, to)
  end
end
