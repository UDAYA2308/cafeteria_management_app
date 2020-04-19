class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.bigint :user_id
      t.timestamp :date
      t.timestamp :delivered_at
      t.string :status

      t.timestamps
    end
  end
end
