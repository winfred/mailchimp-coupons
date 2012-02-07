class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :username
      t.string :apikey
      t.integer :coupons_count, default: 0

      t.timestamps
    end
    add_index :users, :user_id
  end
end
