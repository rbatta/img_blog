class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :category
      t.integer :image_id

      t.timestamps
    end
    add_index :categories, :category
    add_index :categories, :image_id
  end
end
