class @LoadViewModel
	constructor: (@model) ->
		@items = kb.collectionObservable @model,
			view_model: LoadItemViewModel

	cancel: ->
		router.navigate '/', {trigger: true}

class @LoadItemViewModel extends kb.ViewModel
	constructor: (model, options) ->
		super model, options

		@displayTitle = ko.computed =>
			if @title() == ""
				return "(no title)"
			@title()

		@displayDate = ko.computed =>
			new Date(@created_at()).format()

	open: ->
		router.navigate '/' + @id(), trigger: true

