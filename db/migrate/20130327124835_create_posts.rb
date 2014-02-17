class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :titulo
      t.string :bajada
      t.text :multimedia
      t.string :fuente
      t.references :site
      t.references :user
      t.timestamps
    end
    add_index :posts, :site_id
  end
end
