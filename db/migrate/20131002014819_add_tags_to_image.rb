class AddTagsToImage < ActiveRecord::Migration
  def change
    add_column :images, :tags, :text
    add_index :images, :tags
  end
end
