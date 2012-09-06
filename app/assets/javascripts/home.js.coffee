# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


################################################################################
# Constants
NONE = 'none'


################################################################################
# Models
class @Recommendation extends ko.Model
	@persistAt 'recommendation'
	@fields 'title', 'buttons', 'modes', 'application_name', 'application_long_name'

	@defaultValues: ->
		title: 'untitled'
		application_name: 'app'
		application_long_name: '/Applications/something'
		buttons: ({} for i in [1..8])
		modes: ({} for i in [1..4])

################################################################################
# ViewModels
class @ButtonViewModel
	constructor: (@btn) ->
		@text = ko.computed -> 'button!'

	edit: -> alert("edit button")


class @ModeViewModel
	constructor: (@mode) ->
		@text = ko.computed -> 'mode!'

	edit: -> alert("edit mode")


class @HomeViewModel
	constructor: (@model) ->
		@buttons = (new ButtonViewModel(x) for x in @model.buttons())
		@modes = (new ModeViewModel(x) for x in @model.modes())
		@title = @model.title
		@application_name = @model.application_name
		@application_long_name = @model.application_long_name

		@isDirty = ko.observable(false)

	load: ->
		# TODO



################################################################################
# Bootstrap
$ ->
	window.vm = new HomeViewModel(new Recommendation(
		Recommendation.defaultValues()))
	ko.applyBindings(window.vm)
