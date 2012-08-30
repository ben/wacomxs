class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|

      t.timestamps

		t.string :title
		t.string :settings
    end
  end
end
