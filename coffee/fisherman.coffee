define(['npc'], (NPC)->
	class Fisherman extends NPC
		move_scene: ->

		create_images: ->
            @images =
                up: x: 1, y: 0
                left: x: 3, y: 0
                down: x: 2, y: 0
                right: x: 4, y: 0

        set_stats: ->
        	@name = 'Fisherman'
        	@phrases = [
                "My family's fished these waters for 4 generations"
            ]
            @phrase_index = 0
            @selling = false
            @item_id = 2 # fish

)
