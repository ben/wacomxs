class @ImportInnerViewModel
	constructor: (@el) ->
		
		# Bindables
		@selectedAppId = ko.observable()
		@selectedTablet = ko.observable()

		# General properties of the apps
		@appMap = {}
		@el.find('ApplicationMap').children().each (i,el) =>
			id = $(el).prop('tagName').match(/appid(\d+)/i)[1]
			@appMap[id] =
				appId: id
				name: $(el).find('ApplicationName').text()
				longName: $(el).find('ApplicationLongName').text()
				tablets: {}
				secondaryId: $(el).find('ApplicationSecondaryId').text()

		#console.debug @appMap

		# Find the app-specialized bits, walk up to attach them to tablets
		$(el).find('ApplicationAssociated').each (i,appNode) =>
			appNode = $(appNode)
			appId = appNode.text()
			appMapEntry = @appMap[appId]

			tabletName = appNode.parent().parent().parent().find('TabletName').text()
			appMapEntry.tablets[tabletName] ?= {name: tabletName}

			thingNode = appNode.parent()
			type = appNode.parent().parent().prop('tagName').toLowerCase()
			switch type
				when 'tabletappradialmenumaparray'
					appMapEntry.tablets[tabletName].menu = @processMenu thingNode.children('RadialZones')
					#console.debug "Menu! #{appId} / #{tabletName}", appMapEntry.tablets[tabletName].menu
				when 'tabletapptouchfunctions'
					appMapEntry.tablets[tabletName].gestures = @processTouch(thingNode)
					#console.debug "Gestures! #{appId} / #{tabletName}", appMapEntry.tablets[tabletName].gestures
				when 'tabletcontrolcontainerarray'
					appMapEntry.tablets[tabletName].controls = @processButtonsAndRings(thingNode)
					#console.debug "Controls! #{appId} / #{tabletName}", appMapEntry.tablets[tabletName].controls
			@appMap[appId] = appMapEntry

		# Leave out the '0' appId
		@appArray = (@appMap[k] for k in _.rest(Object.keys(@appMap)))

		@tablets = ko.computed =>
			return [] if not @selectedAppId()
			tablets = @appMap[@selectedAppId()].tablets
			tablets[k] for k in Object.keys(tablets)

		@valid = ko.computed =>
			@selectedAppId() and @selectedTablet()

	toJSON: ->
		app = @appMap[@selectedAppId()]
		tab = app.tablets[@selectedTablet()]
		ret =
			title: "#{tab.name} – #{app.name}"
			application_name: app.name
			application_long_name: app.longName
			secondary_id: app.secondaryId
			buttons: tab.controls.buttons
			modes: tab.controls.rings
			gestures: tab.gestures
			menu: tab.menu
			include_buttons: tab.controls.buttons?
			include_rings: tab.controls.rings?
			include_menu: tab.menu?
			include_gestures: tab.gestures?

	processMenu: (node) ->
		@processRadialZone(dir) for dir in $(node).children()

	processRadialZone: (dir) ->
		dir = $(dir)
		ret =
			name: dir.prop('tagName').toLowerCase()
			radialFunction: dir.children('RadialFunction').text()
			radialStringName: dir.children('RadialStringName').text()
		handle = $ dir.children('RadialFunctionHandle').children()[0]
		if handle.length > 0
			switch handle.prop('tagName').toLowerCase()
				when 'keystroke'
					ret.keystroke = handle.text()
				when 'radialzones'
					ret.radialZones = @processMenu handle
				when 'runappstringname'
					ret.runAppStringName = handle.text()
		ret

	simpleGestureNode: (node, name) ->
		name: name
		value: node.children(name).text()
		type: node.children(name).attr('type')

	complexGestureNode: (node, name) ->
		name: name
		commandId: node.children(name).children('commandID').text()
		commandData: node.children(name).children('commandData').text()
		commandDisplayName: node.children(name).children('commandDisplayName').text()

	processTouch: (node) ->
		simple: (@simpleGestureNode(node, name) for name in [
			'AddAFingerToLeftClickEnabled',
			'AddAFingerToRightClickEnabled',
			'ApplicationAssociated',
			'CursorAccelerationCurve',
			'CursorSpeed',
			'DoubleClickAssistMultiplier',
			'DragEnabled',
			'DragLockEnabled',
			'Gesture3FDragEnabled',
			'Gesture3FSwipeDownEnabled',
			'Gesture3FSwipeEnabled',
			'Gesture3FSwipeUpEnabled',
			'Gesture5FTapHoldEnabled',
			'GestureRotateEnabled',
			'GestureScrollBehavior',
			'GestureScrollDirection',
			'GestureScrollEnabled',
			'GestureSmartZoomEnabled',
			'GestureSwipeEnabled',
			'GestureZoomEnabled',
			'ScrollingSpeed',
			'Tap2ToRightClickEnabled',
			'TapToClickEnabled',
			'Gesture3FTapHoldEnabled',
			'Gesture4FPinchEnabled',
			'Gesture4FSpreadEnabled',
			'Gesture4FSwipeDownEnabled',
			'Gesture4FSwipeLeftRightEnabled',
			'Gesture4FSwipeUpEnabled',
			'Gesture5FSwipeDownEnabled',
		])
		complex: (@complexGestureNode(node, name) for name in [
			'Gesture3FTapAndHold',
			'Gesture4FSwipeDown',
			'Gesture4FSwipeUp',
			'Gesture5FSwipeDown',
			'Gesture5FTapAndHold',
		])

	processButton: (node) ->
		node = $(node)
		ret =
			buttonName: node.children('ButtonName').text()
			buttonFunction: node.children('ButtonFunction').text()
			modifier: node.children('Modifier').text()
			buttonKeystrokeShortcutName: node.children('ButtonKeystrokeShortcutName').text()
			keystroke: node.children('Keystroke').text()

	processMode: (node) ->
		node = $(node)
		ret = 
			touchStripDirection: node.children('TouchStripDirection').text()
			touchStripEnableTapZones: node.children('TouchStripEnableTapZones').text()
			touchStripFunction: node.children('TouchStripFunction').text()
			touchStripKeystrokeDecrease: node.children('TouchStripKeystrokeDecrease').text()
			touchStripKeystrokeIncrease: node.children('TouchStripKeystrokeIncrease').text()
			touchStripKeystrokeName: node.children('TouchStripKeystrokeName').text()
			touchStripModeName: node.children('TouchStripModeName').text()
			touchStripModifiers: node.children('TouchStripModifiers').text()
			touchStripSpeed: node.children('TouchStripSpeed').text()

	processModes: (node) ->
		# I4 has this structure:
		#   TouchRingSettings/TouchStripModes/mode[1,2...]
		# Multi-ring tablets have this structure:
		#   TouchRings/(Left|Right)Ring/TouchStripModes/mode[1,2...]
		rings = node.children('TouchRingSettings')
		if rings.length == 0
			rings = node.children('TouchRings').children()
		if rings.length == 0
			return null

		rings.map((i,el) =>
			name: el.localName
			modes: ($(el).find("TouchStripModes").children().map (i,el) =>
				@processMode el
			).toArray()
		).toArray()

	processButtonsAndRings: (node) ->
		ExpressKeysShowButtonHUD: node.children('ExpressKeysShowButtonHUD').text()
		TouchRingShowButtonHUD: node.children('TouchRingShowButtonHUD').text()
		buttons: _.map node.children('TabletControlsButtonsArray').children(), @processButton
		rings: @processModes node


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
				new ImportInnerViewModel($($.parseXML @unescapedData()))
			else
				null

		@submitDisabled = ko.computed =>
			if !@innerVM() or !@innerVM().valid()
				return true
			if @busy()
				return true
			false

	submit: ->
		return if @submitDisabled()

		@busy(true)
		json = @innerVM().toJSON()
		r = new Recommendation json
		console.log json, r

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

