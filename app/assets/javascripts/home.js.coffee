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
				if (file)
					reader = new FileReader()
					reader.onload = (e) =>
						valueAccessor()(e.target.result)
					reader.readAsArrayBuffer(file)
				else
					valueAccessor()(file)


################################################################################
# Constants
NONE = 'none'


################################################################################
# Models
class @Recommendation extends Backbone.Model

class @RecommendationCollection extends Backbone.Collection
	model: Recommendation
	url: '/recommendations'

################################################################################
# ViewModels
class @MasterViewModel

	constructor: ->
		@importVM = ko.observable(new ImportViewModel())
		@loadVM = ko.observable(2)

	new: ->


class @ImportViewModel
	constructor: ->
		@filedata = ko.observable()
		@disabled = ko.computed =>
			!@filedata()

	submit: ->
		@filedata(null)
		$('#importfile').attr('value', null)
		$('#import').modal('hide')


################################################################################
# Routes
class @Router extends Backbone.Router
	routes:
		'new':						'new'
		'*path':						'dashboard'

	new: ->
		window.vm.new()
	dashboard: ->

################################################################################
# Bootstrap
@vm
$ ->
	window.router = new Router()
	window.vm = new MasterViewModel()
	Backbone.history.start()
	ko.applyBindings(window.vm)
