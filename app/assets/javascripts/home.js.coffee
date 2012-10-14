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
# Models
class @Recommendation extends Backbone.Model
	urlRoot: '/recommendations'

class @RecommendationCollection extends Backbone.Collection
	model: Recommendation
	url: '/recommendations'

################################################################################
# ViewModels
class @MasterViewModel

	constructor: ->
		@importVM = ko.observable(new ImportViewModel())
		@loadVM = ko.observable(2)

	doImport: ->
		router.navigate '/import', {trigger: true}


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

		@submitDisabled = ko.computed => !@selectedApp()

	submit: ->
		a = @apps()[@selectedApp()]
		console.log a
		buttons = @extractButtons(a.id)
		modes = @extractModes(a.id)
		r = new Recommendation(
			application_name: a.name
			application_long_name: a.longName
			buttons: buttons
			modes: modes
			title: ''
		)
		r.save
			success: -> router.navigate id, {trigger: true}
		console.log r.toJSON()
		@filedata(null)
		@selectedApp(null)
		$('#importfile').attr('value', null)

	cancel: ->
		router.navigate '/', {trigger: true}

	extractButtons: (id) -> null
	extractModes: (id) -> null


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
$ =>
	@router = new Router()
	vm = new MasterViewModel()
	Backbone.history.start({pushState: true})
	ko.applyBindings(vm)

	# For debugging
	window.router = @router
	window.vm = vm
	window.Recommendation = @Recommendation
	window.RecommendationCollection = @RecommendationCollection
