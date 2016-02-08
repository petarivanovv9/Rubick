class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :password_hash
    end
  end
end
