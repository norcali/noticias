class AddFotoToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :foto, :string
  end
end
