class Recommendation < ActiveRecord::Base
	attr_accessible :title, :settings
	serialize :settings
end
