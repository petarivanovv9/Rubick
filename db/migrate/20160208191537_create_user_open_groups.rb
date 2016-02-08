class CreateUserOpenGroups < ActiveRecord::Migration
  def change
    create_table :user_open_groups do |t|
      t.integer :open_group_id
      t.integer :user_id
    end
  end
end
