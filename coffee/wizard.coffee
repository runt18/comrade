define(['entity'], (Entity)->
	class Wizard extends Entity
		move_scene: ->

		create_images: ->
            @images =
                up: x: 1, y: 2
                left: x: 3, y: 2
                down: x: 2, y: 2
                right: x: 4, y: 2

        set_stats: ->
        	@name = 'Wizard'
        	@phrases = [
        		'Hello'
        		'Welcome to Comrade'
        		'If you want to earn some money, try gathering some resources'
        		"I'll buy logs, fish and rocks"
        		'You can use this money to buy better tools'
        		'You can also buy weapons and armour to fight the spiders'
        		"Here's a Basic Pickaxe to get you started. Try mining some rocks."
        	]
        	@phrase_index = 0

        say: ->
        	$dialogue = $ '#dialogue'
        	phrase = @phrases[@phrase_index]
        	$dialogue.append $('<p>').text "#{@name}: #{phrase}"
        	$dialogue.scrollTop $dialogue[0].scrollHeight
        	@phrase_index += 1
        	@phrase_index = 0 if @phrase_index is @phrases.length

	new Wizard
)
