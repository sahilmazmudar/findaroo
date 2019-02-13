class User < ApplicationRecord
	validates :email, uniqueness: true
	validates :budget, numericality: 		{ greater_than_or_equal_to: 1}
	validates :lease_duration, numericality:{ greater_than_or_equal_to: 1, 
											  less_than_or_equal_to: 16}
	validates :cleanliness, numericality: 	{ greater_than_or_equal_to: 1, 
											  less_than_or_equal_to: 5}
	validates :quietness, numericality: 	{ greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
end
