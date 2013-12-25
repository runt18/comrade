define(['entity', 'game', 'scene', 'pathfinding'], (Entity, g, s, pathfinding) ->
    finder = new pathfinding.AStarFinder()

    class Creature extends Entity
        move_scene: ->

        set_stats: ->
            @health = 5
            @attack = 1
            @pathfind()
            @moving_along_path = false

        create_images: ->
        	@images =
                up: x: 1, y: 4
                left: x: 3, y: 4
                down: x: 2, y: 4
                right: x: 4, y: 4

        pathfind: (end_coords)->
            if not end_coords
                end_coords = s.current.empty_tiles[Math.floor(Math.random() * s.current.empty_tiles.length)]

            @path = finder.findPath(@pos.x, @pos.y, end_coords.x, end_coords.y, s.current.graph)

            @pathi = 0
            @moving_along_path = true

        move_along_path: ->
            if @pathi is @path.length
                @moving_along_path = false
                return
            next_point = @path[@pathi]
            if next_point.x is Math.round @pos.x
                # moving along the y axis
                direction = next_point.y - @pos.y
                axis = 'y'
            else
                # moving along the x axis
                direction = next_point.x - @pos.x
                axis = 'x'

            @move axis, direction
            @pathi += 1
)
