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
		}
		ret.title = ret.application_name
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

