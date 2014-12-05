class AddRoleToUsers < ActiveRecord::Migration
  def change
    # remove_column :movies, :movie_poster
    # remove_column :movies, :poster_image_url
    add_column :users, :role, :integer, :default => 0
  end
end
