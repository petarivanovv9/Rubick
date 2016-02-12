class CreateOpenGroupPostComments < ActiveRecord::Migration
  def change
    create_table :open_group_post_comments do |t|
      t.integer :user_id
      t.integer :open_group_post_id
      t.text :content
    end
  end
end
