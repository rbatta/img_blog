class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :img_url
      t.string :img_name
      t.string :description
      t.integer :user_id

      t.timestamps
    end
    add_index :images, [:user_id, :created_at]
  end
end
