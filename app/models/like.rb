class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :item

	scope :liked, -> { where(like: true) }
	scope :disliked, -> { where(dislike: true) }
end
