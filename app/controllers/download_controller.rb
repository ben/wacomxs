class DownloadController < ApplicationController
	def win
		send_data "<?xml>Win!</xml>",
			:type => 'text/xml; charset=utf-8',
			:disposition => "attachment; filename=win.xml"
	end

	def mac
		send_data "<?xml>Mac!</xml>",
			:type => 'text/xml; charset=utf-8',
			:disposition => "attachment; filename=mac.xml"
	end

	def all
		send_data "<?xml>All!</xml>",
			:type => 'text/xml; charset=utf-8',
			:disposition => "attachment; filename=all.xml"
	end
end
