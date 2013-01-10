class AddStockToComments < ActiveRecord::Migration
  def change
    add_column :comments, :stock_id, :integer   
  end
end
