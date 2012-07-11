define(['entity', 'game', 'scene', 'graph', 'astar'], (Entity, g, s, Graph, astar)->
    class Creature extends Entity
        move_scene: ->

        set_stats: ->
            @health = 5
            @attack = 1
            @pathfind()
            @pathfinding = false

        create_images: ->
        	@images =
                up: x: 1, y: 4
                left: x: 3, y: 4
                down: x: 2, y: 4
                right: x: 4, y: 4

        pathfind: ->
            graph = new Graph g.objects
            start = graph.nodes[@pos.x][@pos.y]
            end = s.current.empty_tiles[Math.floor Math.random() * s.current.empty_tiles.length]
            end = graph.nodes[end.x][end.y]
            @path = astar.search graph.nodes, start, end
            @pathi = 0
            @pathfinding = true
            # log @path

        move_along_path: ->
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
            if @pathi is @path.length
                @pathfinding = false



)
