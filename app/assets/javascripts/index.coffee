# check si DOM ready
jQuery ->

	#  faire apparaître le modal de groupes
	$('#link_to_my_groups, .close_modal_link').click((event)->
		event.preventDefault()
		$('#modal_wrapper').fadeToggle()
		$('#modal_wrapper').css({"display": "flex", "justify-content": "center", "align-items": "center"})
		)