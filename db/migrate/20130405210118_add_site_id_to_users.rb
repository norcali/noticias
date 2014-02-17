class AddSiteIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :site_id, :string
  end
end
