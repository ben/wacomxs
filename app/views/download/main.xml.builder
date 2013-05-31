xml.instruct!

def mode_as_touchstrip(xml, m)
	xml.TouchStripDirection m[:touchStripDirection], :type => :integer
	xml.TouchStripEnableTapZones m[:touchStripEnableTapZones], :type => :bool
	xml.TouchStripFunction m[:touchStripFunction], :type => :integer
	xml.TouchStripKeystrokeDecrease :type => :kestring do
		xml.cdata! m[:touchStripKeystrokeDecrease]
	end
	xml.TouchStripKeystrokeIncrease :type => :kestring do
		xml.cdata! m[:touchStripKeystrokeIncrease]
	end
	xml.TouchStripKeystrokeName m[:touchStripKeystrokeName], :type => :string
	xml.TouchStripModeName m[:touchStripModeName], :type => :string
	xml.TouchStripModifiers m[:touchStripModifiers], :type => :integer
	xml.TouchStripSpeed m[:touchStripSpeed], :type => :integer
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

def button_array_element(xml, b, replace=nil, with=nil)
	xml.ArrayElement :type => :map do
		name = b[:buttonName]
		name.sub! replace, with unless replace.nil?
		xml.ButtonName b[:buttonname], :type => :integer
		xml.ButtonFunction b[:buttonfunction], :type => :integer
		unless b[:keystrokeShortcutName].nil?
			xml.ButtonKeystrokeShortcutName b[:keystrokeShortcutName], :type => :string
		end
		if b.has_key? :keystroke
			xml.Keystroke :type => :kestring do
				xml.cdata! b[:keystroke]
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
		xml.ArrayElement :type => :map do

			# TODO
			if @reco.include_menu
				xml.TabletAppRadialMenuMapArray :type => :array do
					xml.ArrayElement :type => :map do
						xml.ApplicationAssociated 1, :type => :integer
					end
				end
			else
				xml.comment! 'radial menu excluded'
			end

			# TODO
			if @reco.include_gestures
				xml.TabletAppTouchFunctions :type => :array do
					xml.ArrayElement :type => :map do
						xml.ApplicationAssociated 1, :type => :integer
					end
				end
			else
				xml.comment! 'gestures excluded'
			end

			xml.TabletControlContainerArray :type => :array do
				xml.ArrayElement :type => :map do
					xml.ApplicationAssociated 1, :type => :integer

					if @reco.include_buttons
						xml.TabletControlsButtonsArray :type => :array do
							xml.comment! "This is a dumb mirroring. It could be better."
							xml.comment! "Left buttons"
							@reco.buttons.each do |b|
								button_array_element xml, b
							end
							xml.comment! "Right buttons"
							@reco.buttons.each do |b|
								button_array_element xml, b, "Left", "Right"
							end
						end
					else
						xml.comment! 'buttons excluded'
					end

					# TODO
					xml.TabletControlsModButtonsArray :type => :array do
					end

					if @reco.include_rings
						xml.TouchRings :type => :map do
							# C24
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
					else
						xml.comment! 'touch rings excluded'
					end

				end # ArrayElement
			end # TabletControlContainerArray

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
