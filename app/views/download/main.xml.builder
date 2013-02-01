xml.instruct!

def mode_as_touchstrip(xml, m)
	xml.TouchStripDirection m[:direction], :type => :integer
	xml.TouchStripEnableTapZones m[:enableTapZones], :type => :bool
	xml.TouchStripFunction m[:stripFunction], :type => :integer
	xml.TouchStripKeystrokeDecrease :type => :kestring do
		xml << m[:keystrokeDecrease]
	end
	xml.TouchStripKeystrokeIncrease :type => :kestring do
		xml << m[:keystrokeIncrease]
	end
	xml.TouchStripKeystrokeName m[:keystrokeName], :type => :string
	xml.TouchStripModeName m[:name], :type => :string
	xml.TouchStripModifiers m[:modifiers], :type => :integer
	xml.TouchStripSpeed m[:speed], :type => :integer
end

def touch_strip_modes(xml)
	xml.TouchStripModes :type => :array do
		@reco.modes[0][:modes].each_index do |i|
			xml.tag! "mode#{i+1}" do
				mode_as_touchstrip xml, @reco.modes[0][:modes][i]
			end
		end
	end
end

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
						# This currently spits out all the buttons, in order, dumbly. Need a way to control mirroring and sides.
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

					xml.TouchRings :type => :map do
						# C24 touch rings live at this level
						['Left','Right'].each do |pos|
							xml.tag! "#{pos}Ring", :type => :map do
								touch_strip_modes xml
							end
						end
					end

					xml.TouchRingSettings :type => :map do
						# I4/I5
						touch_strip_modes xml
					end

					xml.TouchStrips :type => :map do
						# C22, C21
						[1,2].each do |i|
							xml.tag! "oned#{i}", :type => :map do
								touch_strip_modes xml
							end
						end
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
