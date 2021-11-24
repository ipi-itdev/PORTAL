class AddPostToAnnouncement < ActiveRecord::Migration[5.1]
  def change
    add_column :announcements, :post, :boolean
  end
end
