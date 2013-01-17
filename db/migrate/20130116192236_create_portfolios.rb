class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.decimal :cash
      t.references :stock
      t.references :user

      t.timestamps
    end
    add_index :portfolios, :stock_id
    add_index :portfolios, :user_id
  end
end
