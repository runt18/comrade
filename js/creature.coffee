define(['entity'], (Entity)->

    class Creature extends Entity
        move_scene: ->

        set_stats: ->
        	@health = 5
        	@attack = 1

        create_images: ->
        	@images =
                up: x: 1, y: 4
                left: x: 3, y: 4
                down: x: 2, y: 4
                right: x: 4, y: 4

)
