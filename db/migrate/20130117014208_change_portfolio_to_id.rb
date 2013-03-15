class ChangePortfolioToId < ActiveRecord::Migration
  def up
#    change_column :stocks, :portfolio, :integer
    rename_column :stocks, :portfolio, :portfolio_id
  end

  def down
  end
end
