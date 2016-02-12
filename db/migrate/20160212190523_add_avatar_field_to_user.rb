class AddAvatarFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string, default: nil
  end
end
