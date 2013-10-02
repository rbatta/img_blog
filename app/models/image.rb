class Image < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :categories
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :description, presence: true, length: { maximum: 250 }
	validates :img_name, presence: true, length: { maximum: 80 }
	validates :tags, presence: true
end
