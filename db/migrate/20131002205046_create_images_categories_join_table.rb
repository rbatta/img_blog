class CreateImagesCategoriesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :images, :categories do |t|
      t.index [:image_id, :category_id]
      t.index [:category_id, :image_id]
    end
  end
end
