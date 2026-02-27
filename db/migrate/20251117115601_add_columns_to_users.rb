class AddColumnsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :nickname, :string, null: false, default: ""
    add_column :users, :region, :string
    add_column :users, :introduction, :text
  end
end
