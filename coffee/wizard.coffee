define(['npc'], (NPC)->
	class Wizard extends NPC
		move_scene: ->

		create_images: ->
            @images =
                up: x: 5, y: 2
                left: x: 7, y: 2
                down: x: 6, y: 2
                right: x: 8, y: 2

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

	new Wizard
)
