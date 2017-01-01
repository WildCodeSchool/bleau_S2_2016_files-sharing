jQuery ->

	add_user = (name)-> 
		$('#users_added').append("<p class="+name+">"+name+"</p>")
		alert "plop"

	$('#search_users').autocomplete
		source: (request, response) ->
            $.getJSON('/search_users?term=' + request.term, (data) ->
                response($.map(data, (item) ->
                    return(label: item.Name, value: item.name, id: item.id))))
		select:  (event, ui) ->
			add_user(ui.item.name)
