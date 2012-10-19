class ChangeColumnTypeForButtonsAndModes < ActiveRecord::Migration
  def up
	  change_table :recommendations do |t|
		  t.change :buttons, :text
		  t.change :modes, :text
	  end
  end

  def down
	  change_table :recommendations do |t|
		  t.change :buttons, :string
		  t.change :modes, :string
	  end
  end
end
