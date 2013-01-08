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

