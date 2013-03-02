class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.decimal :value
      t.decimal :cash
      t.references :portfolio

      t.timestamps
    end
  end
end
