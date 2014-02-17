class AddDescripcionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :descripcion, :string
  end
end