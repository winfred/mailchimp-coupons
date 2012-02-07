class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :user_id
      t.string :list_id
      t.string :list_name
      t.string :name
      t.string :parameter_name
      t.string :tag
      t.timestamps
    end
  end
end
