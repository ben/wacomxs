xml.instruct!

xml.root :type => 'map' do
	xml.ImportFileVersion 3, :type => 'integer'
	xml.OSInterface :type => 'map' do
		xml.ApplicationMap :type => 'map' do
			xml.AppID1 :type => 'map' do
				xml.ApplicationLongName @reco.application_long_name, :type => 'string'
				xml.ApplicationName @reco.application_name, :type => 'string'
			end
		end
	end

	xml.TabletArray :type => 'array' do
		xml.comment! "First ArrayElement is for Opaque Intuos4/5 tablets,Radial Menu, and Ekeys (NOT PENS)"
		xml.ArrayElement :type => 'map' do
			#
			# TODO
			xml.TabletAppRadialMenuMapArray :type => 'array' do
			end

			# TODO
			xml.TabletControlContainerArray :type => 'array' do
			end

			xml.TabletModel :type => 'array' do
				tablet_models.sort.each do |m|
					xml.ArrayElement m, :type => 'integer'
				end
			end

		end
	end
end
