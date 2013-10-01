class Image < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :description, presence: true, length: { maximum: 250 }
	validates :img_name, presence: true, length: { maximum: 80 }
	attr_protected :user_id

end
