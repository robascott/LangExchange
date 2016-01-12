class Language < ActiveRecord::Base
	has_many :natives , :class_name => "User"
	has_many :users, :through => :learning
	has_many :notes
end
