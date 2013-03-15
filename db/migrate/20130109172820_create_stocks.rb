class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :user
      t.string :symbol
      t.decimal :purch_price
      t.date :purch_date
#      t.string :portfolio
      t.integer :portfolio

      t.timestamps
    end
    add_index :stocks, :user_id
  end
end
