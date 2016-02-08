class CreateOpenGroups < ActiveRecord::Migration
  def change
    create_table :open_groups do |t|
      t.string :name
      t.text :description
    end
  end
end
