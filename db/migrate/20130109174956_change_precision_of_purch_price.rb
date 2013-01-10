class ChangePrecisionOfPurchPrice < ActiveRecord::Migration
  def up
    change_column :stocks, :purch_price, :decimal, :precision => 16, :scale => 2
  end

  def down
  end
end
