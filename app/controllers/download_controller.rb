class DownloadController < ApplicationController
	def main
		reco = Recommendation.find_by_id params[:id]
		filename = reco.title.to_ascii.parameterize
		send_data custom_render(reco),
			:type => 'text/xml; charset=utf-8',
			:disposition => "attachment; filename=#{filename}.wacomxs"
	end

	private

	def custom_render(reco)
		reco.to_xml
	end
end
