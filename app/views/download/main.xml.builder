xml.instruct!

xml.root :type => :map do
	xml.ImportFileVersion 3, :type => :integer
	xml.OSInterface :type => :map do
		xml.ApplicationMap :type => :map do
			xml.AppID1 :type => :map do
				xml.ApplicationLongName @reco.application_long_name, :type => :string
				xml.ApplicationName @reco.application_name, :type => :string
			end
		end
	end

	xml.TabletArray :type => :array do
		xml.comment! "First ArrayElement is for Opaque Intuos4/5 tablets,Radial Menu, and Ekeys (NOT PENS)"
		xml.ArrayElement :type => :map do

			# TODO
			xml.TabletAppRadialMenuMapArray :type => :array do
			end

			xml.TabletControlContainerArray :type => :array do
				xml.ArrayElement :type => :map do
					xml.ApplicationAssociated 1, :type => :integer

					xml.TabletControlsButtonsArray :type => :array do
						 xml.comment! "This currently spits out all the buttons, in order, dumbly. Need a way to control mirroring and sides."
						# TODO: helper for
						@reco.buttons.each do |b|
							xml.ArrayElement :type => :map do
								xml.ButtonFunction b[:buttonfunction], :type => :integer
								xml.ButtonName b[:buttonname], :type => :integer
								xml.ButtonKeystrokeShortcutName b[:keystrokeName], :type => :string unless b[:keystrokeName].empty?
								xml.Keystroke b[:keystroke], :type => :kestring if b.has_key? :keystroke
							end
						end
					end

					# TODO
					xml.TabletControlsModButtonsArray :type => :array do
					end

					# TODO
					xml.TouchRings :type => :map do
					end

					xml.TouchRingSettings :type => :map do
					end

					xml.TouchStrips :type => :map do
					end
				end
			end

			xml.TabletModel :type => :array do
				tablet_models.sort.each do |m|
					xml.ArrayElement m, :type => :integer
				end
			end

			xml.TabletType :type => :array do
				tablet_types.sort.each do |t|
					xml.ArrayElement t, :type => :integer
				end
			end

		end
	end
end
