class Note < ActiveRecord::Base
	belongs_to :user
	belongs_to :language

	has_many :comments
end
