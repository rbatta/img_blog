class AddPicturesToImages < ActiveRecord::Migration
  def change
    add_column :images, :pictures, :string
  end
end
