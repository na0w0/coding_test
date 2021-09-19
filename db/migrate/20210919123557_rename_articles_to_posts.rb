class RenameArticlesToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_table :articles, :posts
  end
end
