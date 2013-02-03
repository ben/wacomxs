class AddIncludeFlags < ActiveRecord::Migration
	def change
		change_table :recommendations	do |t|
			t.text :menu
			t.text :gestures

			t.boolean :include_buttons, :default => true
			t.boolean :include_rings, :default => true
			t.boolean :include_menu, :default => true
			t.boolean :include_gestures, :default => true
		end
	end
end
