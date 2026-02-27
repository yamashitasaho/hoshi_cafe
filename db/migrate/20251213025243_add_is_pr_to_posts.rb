class AddIsPrToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :is_pr, :boolean, null: false, default: false
  end
end
