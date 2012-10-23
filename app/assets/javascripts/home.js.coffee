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
		@showVM = ko.observable()

	doImport: ->
		router.navigate '/import', {trigger: true}

	show: (id) ->
		console.log 'Showing', id
		@showVM new ShowViewModel(id)

class @ShowViewModel
	constructor: (id) ->
		@model = new Recommendation(id: id)
		@model.fetch()

class @ImportAppViewModel
	constructor: (data, mapEl, @appid) ->
		@mapEl = $(mapEl)
		@name = @mapEl.find('ApplicationName').text()
		@longName = @mapEl.find('ApplicationLongName').text()

		# How many settings are associated?
		@ctrls = null
		$(data).find('TabletControlContainerArray').children().each (i,el) =>
			thisid = parseInt($(el).find('ApplicationAssociated').text())
			if thisid == @appid
				@ctrls = el

		# Final text to display
		@labelText = @name
		if @longName
			@labelText += " (" + @longName + ")"

		# Stow the settings away for later
		@buttons = @getButtons $(@ctrls).find('TabletControlsButtonsArray').children()
		@modes = @getModes $(@ctrls).find('TouchStripModes').children(),
			$(@ctrls).find('TouchRingModes').children()

		@visible = @ctrls != null

	getButtons: (el) ->
		ret = (el.map ->
			buttonfunction: $(@).find('buttonfunction').text()
			buttonname: $(@).find('buttonname').text()
			modifier: $(@).find('modifier').html()
			keystrokeName: $(@).find('buttonkeystrokeshortcutname').text()
			keystroke: $(@).find('keystroke').html()
		).toArray()
		ret

	getModes: (stripEl, ringEl) ->
		strips = (stripEl.map ->
			direction: $(@).find('TouchStripDirection').text()
			enableTapZones: $(@).find('TouchStripEnableTapZones').text()
			stripFunction: $(@).find('TouchStripFunction').text()
			keystrokeDecrease: $(@).find('TouchStripKeystrokeDecrease').html()
			keystrokeIncrease: $(@).find('TouchStripKeystrokeIncrease').html()
			keystrokeName: $(@).find('TouchStripKeystrokeName').text()
			modeName: $(@).find('TouchStripModeName').text()
			modifiers: $(@).find('TouchStripModifiers').text()
			speed: $(@).find('TouchStripSpeed').text()
		).toArray()
		rings = []
		[].concat(strips,rings)

	toJSON: ->
		application_name: @name
		application_long_name: @longName
		buttons: @buttons
		modes: @modes
		title: ''

class @ImportViewModel
	constructor: ->
		@filedata = ko.observable(null)
		@busy = ko.observable(false)
		@error = ko.observable(null)

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

		@submitDisabled = ko.computed =>
			if !@selectedApp()
				return true
			if @busy()
				return true
			false

	submit: ->
		@busy(true)
		a = @apps()[@selectedApp()]
		console.log 'a', a
		r = new Recommendation(a.toJSON())
		r.save null,
			success: =>
				@clear()
				router.navigate String(r.id), {trigger: true}
			error: (m, resp) =>
				@busy(false)
				@error(resp)

	cancel: ->
		@clear()
		router.navigate '/', {trigger: true}

	clear: ->
		@busy(false)
		@error(null)
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
		':id':						'show'
		'*path':						'dashboard'

	modalOptions:
		show: true
		keyboard: false
		backdrop: 'static'

	import: ->
		$('#import').modal @modalOptions

	load: ->
		$('#load').modal @modalOptions

	new: ->

	show: (id) ->
		$('.modal').modal('hide')
		vm.show parseInt(id)

	dashboard: ->
		$('.modal').modal('hide')

################################################################################
# Bootstrap
@vm
$ =>
	@router = new Router()
	@vm = new MasterViewModel()
	window.vm = @vm
	Backbone.history.start({pushState: true})
	ko.applyBindings(vm)

	# For debugging
	window.router = @router
	window.Recommendation = @Recommendation
	window.RecommendationCollection = @RecommendationCollection
