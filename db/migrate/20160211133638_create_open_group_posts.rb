class CreateOpenGroupPosts < ActiveRecord::Migration
  def change
    create_table :open_group_posts do |t|
      t.integer :user_id
      t.integer :open_group_id
      t.text :content
    end
  end
end
