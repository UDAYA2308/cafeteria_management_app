class AddTypeOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :order_type, :string
  end
end
