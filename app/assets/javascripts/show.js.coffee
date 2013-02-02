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


################################################################################
# View Model
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

		@urlForDownload = "/download/" + model.id

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

	destroy: ->
		if window.confirm "Are you sure you want to destroy this?"
			@model().destroy()
			router.navigate '/', {trigger: true}

