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

ko.bindingHandlers.wacbutton =
	init: (el, valueAccessor) ->
		obj = ko.utils.unwrapObservable(valueAccessor())
		console.log obj
		$(el).text(obj.buttonfunction)


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
		@loadVM = 2
		@showVM = ko.observable()

	doImport: ->
		router.navigate '/import', {trigger: true}

	show: (id) ->
		@showVM(new ShowViewModel(new Recommendation({id:id})))

	dashboard: ->
		@showVM(null)

class @ShowViewModel extends kb.ViewModel
	constructor: (model,options) ->
		super model,
			requires: ['id', 'title', 'buttons', 'modes',
							'application_name', 'application_long_name']
			options: options
		model.fetch()

		@busy = ko.observable(false)
		@success = ko.observable(false)
		@error = ko.observable(false)

	save: ->
		@busy(true)
		@error(false)
		@success(false)
		@model().save null
			success: =>
				@busy(false)
				@success(true)
			error: =>
				@busy(false)
				@error(true)

	download: ->

	destroy: ->
		if window.confirm "Are you sure you want to destroy this?"
			@model().destroy()
			router.navigate '/', {trigger: true}

class @ImportAppViewModel
	constructor: (data, mapEl, @appid) ->
		@mapEl = $(mapEl)
		@name = @mapEl.find('ApplicationName').text()
		@longName = @mapEl.find('ApplicationLongName').text()

		data = $(data)

		# How many settings are associated?
		@ctrls = null
		data.find('TabletControlContainerArray').children().each (i,el) =>
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

		@visible = ko.computed =>
			@ctrls != null and @appid != 0

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

class @ImportInnerViewModel
	constructor: (@el) ->
		# Apps
		apps = @el.find('ApplicationMap').children().map (i,el) ->
			id: i
			name: $(el).find('ApplicationName').text()
			longName: $(el).find('ApplicationLongName').text()

		tablets = @el.find('TabletArray').children().map (i,el) ->
			name: $(el).find('TabletName').text()
			model: $(el).find('TabletModel').text()
			controls: $(el).find('TabletControlContainerArray').children()

		@buttons = ko.observableArray _(tablets).map((tabEl) ->
			tabEl.controls.map((i,ctrlEl) ->
				ctrlEl = $(ctrlEl)
				ret = {}
				ret.tablet = tabEl
				ret.app = apps[parseInt(ctrlEl.find('ApplicationAssociated').text())]
				ret.buttons = ctrlEl.find('TabletControlsButtonsArray').children()
				ret.displayText = tabEl.name + " / " + ret.app.name
				ret
			).toArray()
		).flatten().filter((el)->el.app.id != 0)
		@selectedButtons = ko.observable()

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

		@innerVM = ko.computed =>
			if (@unescapedData())
				new ImportInnerViewModel($(@unescapedData()))
			else
				null

		# Apps for that tablet
		@apps = ko.computed =>
			data = @unescapedData()
			if data
				$(data).find('ApplicationMap').children().map (i,el) ->
					new ImportAppViewModel(data, el, i)
		@visibleApps = ko.computed =>
			_(@apps()).filter (x) -> x.visible()
		@selectedApp = ko.observable()

		@submitDisabled = ko.computed =>
			if !@selectedApp()
				return true
			if @busy()
				return true
			false

		@templateName = ko.computed => String(@submitDisabled()) + 'tmpl'

	submit: ->
		@busy(true)
		a = @apps()[@selectedApp()]
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
		'':							'dashboard'
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
		vm.dashboard()

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
