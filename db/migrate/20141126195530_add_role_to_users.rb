class AddRoleToUsers < ActiveRecord::Migration
  def change
    remove_column :movies, :movie_poster
    add_column :users, :role, :integer, :default => 0
  end
end
