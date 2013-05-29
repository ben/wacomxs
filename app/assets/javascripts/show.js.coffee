################################################################################
# Knockout extensions
ko.bindingHandlers.buttonFunction =
	init: (el, valueAccessor) ->
		val = ko.utils.unwrapObservable(valueAccessor())
		english =
			{
				0:  'None',
				1:  'Left Click',
				2:  'Middle Click',
				3:  'Right Click',
				4:  'Left Double Click',
				5:  'Middle Double Click',
				6:  'Right Double Click',
				7:  'Left Click Lock',
				8:  'Keystrokes',
				9:  'Modifiers',
				10: 'Pressure Hold',
				11: 'Mode Toggle',
				12: 'Macro Deprecated',
				13: 'Screen Macro',
				14: 'Auto Erase',
				15: 'Bumble Free',
				16: 'Erase Keystroke',
				17: 'Erase Modifier',
				18: 'Erase Macro_ Deprecated',
				19: 'Button4 Click',
				20: 'Button5 Click',
				21: 'Middle Click Lock',
				22: 'Right Click Lock',
				23: 'Run Application',
				24: 'Toggle Inking',
				25: 'Tablet PC Tip',
				26: 'Tablet PC Eraser',
				27: 'Tablet PC Barrel',
				28: 'Tablet PC Barrel2',
				29: 'App Defined',
				30: 'T PC Input Panel',
				31: 'Display Toggle',
				32: 'Touch Strip Modifier',
				33: 'Button Panning',
				34: 'Button Set Override',
				35: 'Back',
				36: 'Forward',
				37: 'Journal',
				38: 'Show Desktop',
				39: 'Switch App',
				40: 'Help',
				41: 'Radial Menu',
				42: 'Fine Point',
				43: 'Touch Toggle',
				44: 'Auto Scroll Zoom',
				45: 'Scroll',
				46: 'Zoom',
				47: 'Skip',
				48: 'Run Bamboo Dock',
				49: 'Run Bamboo Preferences',
				50: 'Show All Windows',
				51: 'Rotate',
				52: 'Toggle On Screen Keyboard',
				53: 'Toggle Control Panel',
				54: 'Show All App Windows',
				55: 'Show Next Full Screen App',
				56: 'Show Previous Full Screen App',
				57: 'LCD Settings',
				58: 'Show Dictionary',
				59: 'Metro Desktop Toggle',
			}[parseInt(val)]
		$(el).text(english)

ko.bindingHandlers.radialFunction =
	init: (el, valueAccessor) ->
		val = ko.utils.unwrapObservable(valueAccessor())
		english =
			{
				0: 'Submenu',
				1: 'Keystroke',
				2: 'RunApp',
				3: 'Scaling Absolute',
				4: 'Scaling Relative',
				5: 'Run Browser',
				6: 'Run EMail',
				7: 'Play/Pause',
				8: 'Next Track',
				9: 'Prev Track',
				10: 'Volume Up',
				11: 'Volume Down',
				12: 'Disabled',
				13: 'Close',
				14: 'Precision Mode',
				15: 'Display Toggle',
				16: 'CPL Toggle',
				17: 'Switch App',
			}[parseInt(val)]
		$(el).text(english)


ko.bindingHandlers.modifier =
	init: (el, valueAccessor) ->
		val = ko.utils.unwrapObservable(valueAccessor())
		modArr = val.split ';'
		modArr.pop() # omit last ';'
		$(el).text (s.substring(1) for s in modArr).join(' + ')


################################################################################
# View Model
class @ShowViewModel extends kb.ViewModel
	constructor: (model,options) ->
		super model,
			requires: [
				'id',
				'title',
				'buttons',
				'modes',
				'menu',
				'gestures',
				'application_name',
				'application_long_name'
				'secondary_id',
				'include_buttons',
				'include_rings',
				'include_menu',
				'include_gestures',
			]
			options: options
		model.fetch success: => @dirty(false)
		model.on "change", => @dirty(true)

		@busy = ko.observable(false)
		@success = ko.observable(false)
		@error = ko.observable(false)
		@dirty = ko.observable(false)

		@has_buttons = ko.computed => @buttons()?
		@has_rings = ko.computed => @modes()?
		@has_menu = ko.computed => @menu()?
		@has_gestures = ko.computed => @gestures()?

		@urlForDownload = "/download/" + model.id

	save: ->
		@busy(true)
		@error(false)
		@success(false)
		@model().save null
			success: =>
				@busy(false)
				@success(true)
				@dirty(false)
			error: =>
				@busy(false)
				@error(true)

	destroy: ->
		if window.confirm "Are you sure you want to destroy this?"
			@model().destroy()
			router.navigate '/', {trigger: true}

