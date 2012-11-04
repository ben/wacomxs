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
		@apps = @el.find('ApplicationMap').children().map (i,el) ->
			id: i
			name: $(el).find('ApplicationName').text()
			longName: $(el).find('ApplicationLongName').text()

		@tablets = @el.find('TabletArray').children().map (i,el) ->
			name: $(el).find('TabletName').text()
			model: $(el).find('TabletModel').text()
			controls: $(el).find('TabletControlContainerArray').children()

		@buttons = @mapToTabletAppControls 'TabletControlsButtonsArray'
		strips = @mapToTabletAppControls 'TouchStrips', "Strip"
		rings = @mapToTabletAppControls 'TouchRingSettings', "Ring"
		@modes = strips.concat rings

		@selectedButtons = ko.observable(-1)
		@selectedModes = ko.observable(-1)

		@isValid = ko.computed =>
			@selectedButtons() >= 0 or @selectedModes() >= 0

	mapToTabletAppControls: (selector, type) ->
		arr = _.map @tablets, (tabEl) =>
			tabEl.controls.map((i,ctrlEl) =>
				ctrlEl = $(ctrlEl)
				ret = {}

				# Only collect if the selector has results
				selected = ctrlEl.find(selector).children()
				if (selected.length == 0)
					return null
				ret.values = selected

				ret.tablet = tabEl
				ret.app = @apps[parseInt(ctrlEl.find('ApplicationAssociated').text())]
				ret.displayText = tabEl.name + " / " + ret.app.name
				if type
					ret.displayText = ret.displayText + " (" + type + ")"
				ret
			).toArray()
		_.flatten(arr).filter((el)->el.app.id != 0)

	toJSON: ->
		appData = @modes[@selectedModes()].app
		if @selectedButtons() >= 0
			appData = @buttons[@selectedButtons()].app
		ret = {
			application_name: appData.name
			application_long_name: appData.longName
			title: ''
		}
		if @selectedButtons() > 0
			ret.buttons = @buttons[@selectedButtons()]
		if @selectedModes() > 0
			ret.modes = @modes[@selectedModes()]
		ret
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

		@submitDisabled = ko.computed =>
			if !@innerVM() or !@innerVM().isValid()
				return true
			if @busy()
				return true
			false

	submit: ->
		if @submitDisabled()
			return

		@busy(true)
		r = new Recommendation @innerVM().toJSON()
		console.log r
		# TODO: re-enable this when innerVM.toJSON works
		@busy(false)
		return

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
