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
		@importVM = new ImportViewModel()
		@loadVM = ko.observable(2)

	doImport: ->
		router.navigate '/import', {trigger: true}

class @ImportAppViewModel
	constructor: (data, mapEl, @id) ->
		@mapEl = $(mapEl)
		@name = @mapEl.find('ApplicationName').text()
		@longName = @mapEl.find('ApplicationLongName').text()
		console.log @name, @id

		# How many settings are associated?
		@ctrls = null
		$(data).find('TabletControlContainerArray').find('ApplicationAssociated').each (i,el) =>
			thisid = parseInt($(el).text())
			if thisid == @id
				@ctrls = el

		# Final text to display
		@labelText = @name
		if @longName
			@labelText += " (" + @longName + ")"

		@visible = @ctrls != null

	toJSON: ->
		application_name: @name
		application_long_name: @longName
		buttons: []
		modes: []
		title: ''

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
					new ImportAppViewModel(data, el, i)
		@visibleApps = ko.computed =>
			_(@apps()).filter (x) -> x.visible
		@selectedApp = ko.observable()

		@submitDisabled = ko.computed => !@selectedApp()

	submit: ->
		a = @apps()[@selectedApp()]
		console.log a
		buttons = @extractButtons(a.id)
		modes = @extractModes(a.id)
		r = new Recommendation(a.toJSON())
		r.save success: -> router.navigate id, {trigger: true}
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
