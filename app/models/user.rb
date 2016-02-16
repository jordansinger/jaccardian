class User < ActiveRecord::Base
	has_many :likes, dependent: :destroy
	has_many :items, through: :likes

	def liked_items
		self.items.where('like = ?', true)
	end

	def disliked_items
		self.items.where('dislike = ?', true)
	end

	def similarity_with(user)
		agreements = (self.liked_items & user.liked_items).size
		agreements += (self.disliked_items & user.disliked_items).size

		disagreements = (self.liked_items & user.disliked_items).size
		disagreements += (self.disliked_items & user.liked_items).size

		total = self.likes | user.likes

		return (agreements - disagreements) / total.size.to_f
	end

	def prediction_for(item)
		hive_mind_sum = 0.0
		rated_by = item.likes.size

		item.liked_by.each { |u| hive_mind_sum += self.similarity_with(u) }
		item.disliked_by.each { |u| hive_mind_sum -= self.similarity_with(u) }

		return hive_mind_sum / rated_by.to_f
	end
end
