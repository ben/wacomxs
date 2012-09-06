class Recommendation < ActiveRecord::Base
	attr_accessible :title, :buttons, :modes, :application_name, :application_long_name
	serialize :buttons
	serialize :modes
end
