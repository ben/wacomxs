class Recommendation < ActiveRecord::Base
	attr_accessible \
		:title,
		:buttons,
		:modes,
		:application_name,
		:application_long_name,
		:include_buttons,
		:include_rings,
		:include_menu,
		:include_gestures

	serialize :buttons
	serialize :modes
	serialize :menu
	serialize :gestures
end
