class CreateViewedPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :viewed_posts do |t|
      t.integer :article_id
      t.integer :user_id
      t.timestamps
    end
  end
end
