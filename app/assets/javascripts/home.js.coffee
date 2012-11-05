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

class @ImportInnerViewModel
	constructor: (@el) ->
		@apps = @el.find('ApplicationMap').children().map (i,el) ->
			id: i
			name: $(el).find('ApplicationName').text()
			longName: $(el).find('ApplicationLongName').text()

		@tablets = @el.find('TabletArray').children().map (i,el) ->
			name: $(el).find('TabletName').text()
			model: $(el).find('TabletModel').text()
			controls: $(el).find('TabletControlContainerArray').children()

		@buttons = @extractButtons()
		@modes = @extractModes()

		@selectedButtons = ko.observable(-1)
		@selectedModes = ko.observable(-1)

		@isValid = ko.computed =>
			@selectedButtons() >= 0 or @selectedModes() >= 0

	extractButtons: ->
		arr = _.map @tablets, (tabEl) =>
			tabEl.controls.map((i,ctrlEl) =>
				ctrlEl = $(ctrlEl)
				app = @apps[parseInt(ctrlEl.find('ApplicationAssociated').text())]

				# Only collect if the selector has results
				selected = ctrlEl.find('TabletControlsButtonsArray').children()
				if (selected.length == 0)
					return null

				{
					buttons: @extractAllButtons selected
					tablet: tabEl
					app: app
					displayText: tabEl.name + " / " + app.name
				}
			).toArray()
		_.flatten(arr).filter((el)->el.app.id != 0)

	extractAllButtons: (btns) ->
		btns.map((i,b) ->
			b = $ b
			{
				buttonfunction: b.find('buttonfunction').text()
				buttonname: b.find('buttonname').text()
				modifier: b.find('modifier').html()
				keystrokeName: b.find('buttonkeystrokeshortcutname').text()
				keystroke: b.find('keystroke').html()
			}
		).toArray()

	extractModes: ->
		@extractStrips().concat @extractRings()

	extractStrips: ->
		# PTZ/DTZ have touch strip modes in this structure:
		#   TouchStrips/(Left|Right)OneD/TouchStripModes
		arr = _.map @tablets, (tabEl) =>
			tabEl.controls.map((i, ctrlEl) =>
				ctrlEl = $(ctrlEl)
				strips = ctrlEl.find('TouchStrips').children()
				if strips.length == 0
					return null

				app = @apps[parseInt(ctrlEl.find('ApplicationAssociated').text())]
				{
					tablet: tabEl
					app: app
					displayText: tabEl.name + ' / ' + app.name
					strips: @extractAllModes strips
				}
			).toArray()
		_.flatten(arr).filter (el)->el.app.id != 0

	extractRings: ->
		# I4 has this structure:
		#   TouchRingSettings/TouchStripModes
		# Multi-ring tablets have this structure:
		#   TouchRings/(Left|Right)Ring/TouchStripModes
		arr = _.map @tablets, (tabEl) =>
			tabEl.controls.map((i, ctrlEl) =>
				ctrlEl = $(ctrlEl)
				rings = ctrlEl.find('TouchRingSettings')
				if rings.length == 0
					rings = ctrlEl.find('TouchRings').children()
				if rings.length == 0
					return null

				app = @apps[parseInt(ctrlEl.find('ApplicationAssociated').text())]
				{
					tablet: tabEl
					app: app
					displayText: tabEl.name + ' / ' + app.name
					rings: @extractAllModes rings
				}
			).toArray()
		_.flatten(arr).filter (el)->el.app.id != 0

	extractAllModes: (coll) ->
		coll.map((i,el) =>
			name: el.localName
			modes: ($(el).find("TouchStripModes").children().map (i,el) => @extractModesFromEl el).toArray()
		).toArray()

	extractModesFromEl: (el) ->
		el = $(el)
		{
			direction: el.find('TouchStripDirection').text()
			enableTapZones: el.find('TouchStripEnableTapZones').text()
			stripFunction: el.find('TouchStripFunction').text()
			keystrokeDecrease: el.find('TouchStripKeystrokeDecrease').html()
			keystrokeIncrease: el.find('TouchStripKeystrokeIncrease').html()
			keystrokeName: el.find('TouchStripKeystrokeName').text()
			modeName: el.find('TouchStripModeName').text()
			modifiers: el.find('TouchStripModifiers').text()
			speed: el.find('TouchStripSpeed').text()
		}

	toJSON: ->
		if @selectedModes() >= 0
			appData = @modes[@selectedModes()].app
		if @selectedButtons() >= 0
			appData = @buttons[@selectedButtons()].app
		ret = {
			application_name: appData.name
			application_long_name: appData.longName
			title: ''
		}
		if @selectedButtons() >= 0
			ret.buttons = @buttons[@selectedButtons()].buttons
		if @selectedModes() >= 0
			obj = @modes[@selectedModes()]
			ret.modes = obj.strips or obj.rings
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
