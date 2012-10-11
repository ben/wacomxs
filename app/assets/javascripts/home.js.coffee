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


class @ImportDetailsViewModel
	constructor: (@data) ->
		txt = @data()
		# Might be escaped
		if (txt.match(/\<WacomPrefArchive\>/))
			@data(unescape($(txt).find('ContainedFile:first').text()))


class @ImportViewModel
	constructor: ->
		@filedata = ko.observable()
		@importDetails = ko.computed =>
			if @filedata()
				new ImportDetailsViewModel(@filedata) 
			else
				null
		@submitDisabled = ko.computed =>
			!@filedata()

	submit: ->
		@filedata(null)
		$('#importfile').attr('value', null)


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
