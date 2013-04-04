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
				name: $(el).find('ApplicationName').text()
				appId: id
				longName: $(el).find('ApplicationLongName').text()
				tablets: {}
			secondaryId = $(el).find('ApplicationSecondaryId')
			if secondaryId.length > 0
				@appMap[id].secondaryId = secondaryId.text()

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
					appMapEntry.tablets[tabletName].menu = @processMenu thingNode.find('RadialZones')
					#console.debug "Menu! #{appId} / #{tabletName}", appMapEntry.tablets[tabletName].menu
				when 'tabletapptouchfunctions'
					appMapEntry.tablets[tabletName].gestures = @processTouch(thingNode)
					#console.debug "Gestures! #{appId} / #{tabletName}", appMapEntry.tablets[tabletName].gestures
				when 'tabletcontrolcontainerarray'
					appMapEntry.tablets[tabletName].controls = @processButtonsAndRings(thingNode)
					#console.debug "Controls! #{appId} / #{tabletName}", appMapEntry.tablets[tabletName].controls
			@appMap[appId] = appMapEntry

		@appArray = _.map Object.keys(@appMap), (i) => @appMap[i]
		@appArrayForDisplay = _.rest @appArray

		@tablets = ko.computed =>
			return [] if not @selectedAppId()
			console.debug @appMap[@selectedAppId()].tablets

		@valid = ko.computed =>
			@selectedAppId() and @selectedTablet()

	processMenu: (node) ->
		ret = {}
		$(node).children().each (i,dir) =>
			ret[$(dir).prop('tagName').toLowerCase()] = @processRadialZone(dir)
		ret

	processRadialZone: (dir) ->
		dir = $(dir)
		ret =
			radialFunction: dir.children('RadialFunction').text()
			radialStringName: dir.children('RadialStringName').text()
		handle = $ dir.children('RadialFunctionHandle').children()[0]
		if handle.length > 0
			switch handle.prop('tagName').toLowerCase()
				when 'keystroke'
					ret.keystroke = handle.children().text()
				when 'radialzones'
					ret.radialZones = @processMenu handle
				when 'runappstringname'
					ret.runAppStringName = handle.children().text()
		ret

	processGestureNode: (node) ->
		commandId: node.children('commandID').text()
		commandData: node.children('commandData').text()
		commandDisplayName: node.children('commandDisplayName').text()

	processTouch: (node) ->
		AddAFingerToLeftClickEnabled: node.children('AddAFingerToLeftClickEnabled').text()
		AddAFingerToRightClickEnabled: node.children('AddAFingerToRightClickEnabled').text()
		ApplicationAssociated: node.children('ApplicationAssociated').text()
		CursorAccelerationCurve: node.children('CursorAccelerationCurve').text()
		CursorSpeed: node.children('CursorSpeed').text()
		DoubleClickAssistMultiplier: node.children('DoubleClickAssistMultiplier').text()
		DragEnabled: node.children('DragEnabled').text()
		DragLockEnabled: node.children('DragLockEnabled').text()
		Gesture3FDragEnabled: node.children('Gesture3FDragEnabled').text()
		Gesture3FSwipeDownEnabled: node.children('Gesture3FSwipeDownEnabled').text()
		Gesture3FSwipeEnabled: node.children('Gesture3FSwipeEnabled').text()
		Gesture3FSwipeUpEnabled: node.children('Gesture3FSwipeUpEnabled').text()
		Gesture5FTapHoldEnabled: node.children('Gesture5FTapHoldEnabled').text()
		GestureRotateEnabled: node.children('GestureRotateEnabled').text()
		GestureScrollBehavior: node.children('GestureScrollBehavior').text()
		GestureScrollDirection: node.children('GestureScrollDirection').text()
		GestureScrollEnabled: node.children('GestureScrollEnabled').text()
		GestureSmartZoomEnabled: node.children('GestureSmartZoomEnabled').text()
		GestureSwipeEnabled: node.children('GestureSwipeEnabled').text()
		GestureZoomEnabled: node.children('GestureZoomEnabled').text()
		ScrollingSpeed: node.children('ScrollingSpeed').text()
		Tap2ToRightClickEnabled: node.children('Tap2ToRightClickEnabled').text()
		TapToClickEnabled: node.children('TapToClickEnabled').text()
		Gesture3FTapHoldEnabled: node.children('Gesture3FTapHoldEnabled').text()
		Gesture4FPinchEnabled: node.children('Gesture4FPinchEnabled').text()
		Gesture4FSpreadEnabled: node.children('Gesture4FSpreadEnabled').text()
		Gesture4FSwipeDownEnabled: node.children('Gesture4FSwipeDownEnabled').text()
		Gesture4FSwipeLeftRightEnabled: node.children('Gesture4FSwipeLeftRightEnabled').text()
		Gesture4FSwipeUpEnabled: node.children('Gesture4FSwipeUpEnabled').text()
		Gesture5FSwipeDownEnabled: node.children('Gesture5FSwipeDownEnabled').text()
		Gesture3FTapAndHold: @processGestureNode node.children('Gesture3FTapAndHold')
		Gesture4FSwipeDown: @processGestureNode node.children('Gesture4FSwipeDown')
		Gesture4FSwipeUp: @processGestureNode node.children('Gesture4FSwipeUp')
		Gesture5FSwipeDown: @processGestureNode node.children('Gesture5FSwipeDown')
		Gesture5FTapAndHold: @processGestureNode node.children('Gesture5FTapAndHold')

	processButton: (node) ->
		node = $(node)
		ret =
			buttonName: node.children('ButtonName').text()
			buttonFunction: node.children('ButtonFunction').text()
			modifier: node.children('Modifier').text()
			buttonKeystrokeShortcutName: node.children('ButtonKeystrokeShortcutName').text()
			keystroke: node.children('Keystroke').text()

	processStrip: (node) ->
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

	processButtonsAndRings: (node) ->
		ExpressKeysShowButtonHUD: node.children('ExpressKeysShowButtonHUD').text()
		TouchRingShowButtonHUD: node.children('TouchRingShowButtonHUD').text()
		buttons: _.map node.children('TabletControlsButtonsArray').children(), @processButton
		rings: _.map node.children('TouchRingSettings').children().children(), @processStrip

	toJSON: ->
		@appMap[@selectedAppId()]


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

