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

	new Wizard {x: 10, y:10}
)
