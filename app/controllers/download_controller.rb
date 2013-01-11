class DownloadController < ApplicationController
	def main
		@reco = Recommendation.find_by_id params[:id]
		filename = @reco.title.to_ascii.parameterize
		content = render_to_string :template => "download/main",
			:formats => [:xml], :layout => false
		send_data content,
			:type => 'text/xml',
			:disposition => "attachment; filename=#{filename}.wacomxs"
	end

	def raw
		@reco = Recommendation.find_by_id params[:id]
		render :template => 'download/main',
			:formats => [:xml], :layout => false
	end
end
