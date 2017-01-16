# check si DOM ready
jQuery ->
	# ajout d'un nouveau user
	i = 1000
	add_user = (name, id)->
		if !$("#users_added > div#"+name).length
			$('#users_added').append("
				<div id="+name+">
					<p>You will share this file with "+name+"</p>
					<select name='medium[shared_withs_attributes]["+i+"][rights]'>
						<option value='R'>Read only</option>
						<option value='RW'>Read and modify</option>
					</select> 
					<input type='hidden' name='medium[shared_withs_attributes]["+i+"][entity_id]' value="+id+">
					<a href='#' class='remove_user'>Remove this user</a>
				</div>
				")
	++i
	#supression du user ciblé
	$("#users_added").on("click",".remove_user" ,(e) ->
		$(this).parent().remove()
		e.preventDefault()
		)

	# autocomplete pour la recherche de users sur création de média
	$('#search_users').autocomplete
		source: (request, response) ->
			$.getJSON('/search_users?term=' + request.term, (data) ->
				response($.map(data, (item) ->
					return(label: item.name, value: item.name, id: item.id))))
		select:  (event, ui) ->
			add_user(ui.item.label, ui.item.id)
		# permet la sélection auto du premier élément de la liste
		autoFocus: true

	# évite l'envoi du formulaire en cliquant par erreur sur entrée dans l'input de recherche d'users
	$('#search_users').on('keydown', (e) ->
		if e.which == 13
			e.preventDefault()
		)
