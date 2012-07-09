define(['npc'], (NPC)->
	class Lumberjack extends NPC
		move_scene: ->

		create_images: ->
            @images =
                up: x: 9, y: 2
                left: x: 11, y: 2
                down: x: 10, y: 2
                right: x: 12, y: 2

        set_stats: ->
        	@name = 'Lumberjack'
        	@phrases = [
                "Choppin' logs is a good way to make a livin'."
                "How d'you like our little town?"
        	]
        	@phrase_index = 0
)
