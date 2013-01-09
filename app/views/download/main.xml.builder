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
		
	end
end
