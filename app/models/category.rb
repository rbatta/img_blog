class Category < ActiveRecord::Base
	has_and_belongs_to_many :images
	validates :image_id, presence: true
	validates :category, presence: true, length: { maximum: 50 }
end
