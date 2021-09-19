class RemoveArticleFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_reference :comments, :article, null: false, foreign_key: true
  end
end
