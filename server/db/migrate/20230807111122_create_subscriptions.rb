class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :membership 
      t.date :expiry
      t.timestamps
    end
  end
end
