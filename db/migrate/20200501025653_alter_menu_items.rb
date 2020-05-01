class AlterMenuItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :menu_items, :stock, :image_url
    change_column :menu_items, :image_url, :string
  end
end
