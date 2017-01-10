# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# check si DOM ready
jQuery ->
	set_selected_group = (name, id)->
		$('#group-join-submit').value('Ask to join group "' + name + '"')

	# autocomplete pour la recherche de groups pour demander à le rejoindre
	$('#search_groups').autocomplete
		source: (request, response) ->
			$.getJSON('/search_groups?term=' + request.term, (data) ->
				response($.map(data, (item) ->
					return(label: item.name, value: item.name, id: item.id))))
		select:  (event, ui) ->
			set_selected_group(ui.item.label, ui.item.id)
		# permet la sélection auto du premier élément de la liste
		autoFocus: true

	# évite l'envoi du formulaire en cliquant par erreur sur entrée dans l'input de recherche de groupe
	$('#search_users').on('keydown', (e) ->
		if e.which == 13
			e.preventDefault()
		)
