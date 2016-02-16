class Item < ActiveRecord::Base
	has_many :likes, dependent: :destroy
	has_many :users, through: :likes

	def liked_by
		self.users.where('like = ?', true)
	end

	def disliked_by
		self.users.where('dislike = ?', true)
	end
end
