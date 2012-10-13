# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


################################################################################
# Knockout extensions
ko.bindingHandlers.file = 
	init: (el, valueAccessor) ->
		$(el).change ->
			file = @files[0]
			if (ko.isObservable(valueAccessor()))
				valueAccessor()(null)
				if (file)
					reader = new FileReader()
					reader.onload = (e) =>
						valueAccessor()(e.target.result)
					reader.readAsText(file)


################################################################################
# Constants
NONE = 'none'


################################################################################
# Models
class @Recommendation extends Backbone.Model

class @RecommendationCollection extends Backbone.Collection
	model: Recommendation
	url: '/recommendations'

################################################################################
# ViewModels
class @MasterViewModel

	constructor: ->
		@importVM = ko.observable(new ImportViewModel())
		@loadVM = ko.observable(2)

	new: ->


class @ImportViewModel
	constructor: ->
		@filedata = ko.observable()

		# Parse/unescape the input
		@unescapedData = ko.computed =>
			txt = @filedata()
			if txt && txt.match(/\<WacomPrefArchive\>/)
				return unescape $(txt).find('ContainedFile:first').text()
			txt

		# Extract list of apps
		@apps = ko.computed =>
			data = @unescapedData()
			if data
				return $(data).find('ApplicationMap').children().map (i,el) ->
					id: i
					name: $(el).find('ApplicationName').text()
					longName: $(el).find('ApplicationLongName').text()
		@selectedApp = ko.observable()

		@submitDisabled = ko.computed =>
			!@selectedApp()

	submit: ->
		@filedata(null)
		@selectedApp(null)
		$('#importfile').attr('value', null)


################################################################################
# Routes
class @Router extends Backbone.Router
	routes:
		'new':						'new'
		'import':					'import'
		'load':						'load'
		'*path':						'dashboard'

	modalOptions:
		show: true
		keyboard: false
		'backdrop': 'static'

	import: ->
		$('#import').modal @modalOptions

	load: ->
		$('#load').modal @modalOptions

	new: ->

	dashboard: ->
		$('.modal').modal('hide')

################################################################################
# Bootstrap
@vm
$ ->
	window.router = new Router()
	window.vm = new MasterViewModel()
	Backbone.history.start()
	ko.applyBindings(window.vm)
