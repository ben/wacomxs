class AddSecondaryId < ActiveRecord::Migration
	def change
		change_table :recommendations do |t|
			t.string :secondary_id
		end
	end
end
