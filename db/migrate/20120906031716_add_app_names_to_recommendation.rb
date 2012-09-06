class AddAppNamesToRecommendation < ActiveRecord::Migration
	def change
		change_table :recommendations do |t|
			t.string :application_name
			t.string :application_long_name
			t.string :buttons
			t.string :modes

			t.remove :settings
		end
	end
end
