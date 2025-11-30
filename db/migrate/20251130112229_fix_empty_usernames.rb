class FixEmptyUsernames < ActiveRecord::Migration[7.2]
  def up
    User.find_each do |user|
      updates = {}
      updates[:username] = "user_#{user.id}" if user.username.blank?
      updates[:nickname] = user.username || "user_#{user.id}" if user.nickname.blank?
      user.update_columns(updates) if updates.any?
    end
  end

  def down
  end
end