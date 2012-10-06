# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


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
	import: ->
		@importVM(new ImportViewModel())
		@loadVM(null)

	load: ->
		@importVM(null)
		@loadVM(1)

	new: ->
		@importVM(null)
		@loadVM(null)

	constructor: ->
		@importVM = ko.observable()
		@loadVM = ko.observable()

	clearDialogs: ->
		console.log 'Clearing dialogs'
		@importVM(null)
		@loadVM(null)

class @ImportViewModel

################################################################################
# Routes
class @Router extends Backbone.Router
	routes:
		'import':					'import'
		'load':						'load'
		'new':						'new'
		'*path':						'dashboard'

	import: ->
		window.vm.import()
	load: ->
		window.vm.load()
	new: ->
		window.vm.new()
	dashboard: ->
		window.vm.clearDialogs()

################################################################################
# Bootstrap
@vm
$ ->
	window.router = new Router()
	window.vm = new MasterViewModel()
	Backbone.history.start()
	ko.applyBindings(window.vm)
