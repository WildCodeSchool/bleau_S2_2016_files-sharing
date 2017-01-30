# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('turbolinks:load', ->

	#  faire apparaître le modal de groupes
	$('#link_to_my_groups, .close_modal_link').click((event)->
		event.preventDefault()
		$('#modal_wrapper').fadeToggle()
		)
)
