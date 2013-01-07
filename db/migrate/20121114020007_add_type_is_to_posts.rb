class AddTypeIsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :type_is, :string
    add_column :attachments, :description, :string
  end
end
