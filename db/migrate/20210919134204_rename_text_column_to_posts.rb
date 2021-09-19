class RenameTextColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :text, :content
  end
end
