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

	new: ->

	constructor: ->
		@importVM = ko.observable(new ImportViewModel())
		@loadVM = ko.observable(2)


class @ImportViewModel

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
