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

  def self.get_details(order_id)
    user_data = {}
    user_data["name"] = Order.find(order_id).user.first_name
    user_data["date"] = Order.find(order_id).date.to_date
    user_data["email"] = Order.find(order_id).user.email
    user_data
  end
end
