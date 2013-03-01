class AddLastPriceToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :last_price, :decimal, :precision => 10, :scale => 2
    add_column :stocks, :last_price_date, :datetime
    add_column :stocks, :price_change, :decimal, :precision => 10, :scale => 2
  end
end
