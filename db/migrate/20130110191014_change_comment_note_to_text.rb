class ChangeCommentNoteToText < ActiveRecord::Migration
  def up
    change_column :comments, :note, :text
  end

  def down
  end
end
