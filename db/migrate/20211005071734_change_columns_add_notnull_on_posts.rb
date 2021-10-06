class ChangeColumnsAddNotnullOnPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :content, false
  end
end
