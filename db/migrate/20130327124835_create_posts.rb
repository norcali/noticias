class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :news_text
      t.text :multimedia
      t.string :news_source
      t.references :site
      t.references :user
      t.timestamps
    end
    add_index :posts, :site_id
  end
end
