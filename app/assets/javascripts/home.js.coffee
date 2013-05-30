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

ko.bindingHandlers.wacbutton =
	init: (el, valueAccessor) ->
		obj = ko.utils.unwrapObservable(valueAccessor())
		$(el).text(obj.buttonfunction)


################################################################################
# Models
class @Recommendation extends Backbone.Model
	urlRoot: '/recommendations'

class @RecommendationCollection extends Backbone.Collection
	url: '/recommendations'

################################################################################
# ViewModels
class @MasterViewModel
	constructor: ->
		@importVM = new ImportViewModel()
		@loadVM = new LoadViewModel(new RecommendationCollection())
		@showVM = ko.observable()

	doImport: ->
		router.navigate '/import', {trigger: true}

	show: (id) ->
		@showVM(new ShowViewModel(new Recommendation({id:id})))
		window.addPopover 'buttons'
		window.addPopover 'modes'
		window.addPopover 'menu'
		window.addPopover 'gestures'

	doLoad: ->
		router.navigate '/load', {trigger: true}

	load: ->
		@loadVM.items.collection().fetch()

	dashboard: ->
		@showVM(null)

################################################################################
# Routes
class @Router extends Backbone.Router
	routes:
		'':							'dashboard'
		'import':					'import'
		'load':						'load'
		':id':						'show'
		'*path':						'dashboard'

	modalOptions:
		show: true
		keyboard: false
		backdrop: 'static'

	import: ->
		$('#import').modal @modalOptions

	load: ->
		$('#load').modal @modalOptions
		vm.load()

	show: (id) ->
		$('.modal').modal('hide')
		vm.show parseInt(id)

	dashboard: ->
		$('.modal').modal('hide')
		vm.dashboard()

################################################################################
# Bootstrap
@vm
$ =>
	@router = new Router()
	@vm = new MasterViewModel()
	window.vm = @vm
	Backbone.history.start({pushState: true})
	ko.applyBindings(vm)

	# For debugging
	window.router = @router
	window.Recommendation = @Recommendation
	window.RecommendationCollection = @RecommendationCollection

################################################################################
# View code
window.addPopover = (name) ->
	$("[rel=#{name}-popover]").popover
		html: true
		trigger: 'hover'
		placement: 'bottom'
		content: -> $("##{name}-popover").html()
		template: '<div class="popover"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>'
