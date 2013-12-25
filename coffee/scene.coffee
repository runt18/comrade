define(['game', 'pathfinding'], (g, pathfinding) ->

    class Scene
        constructor: (@x, @y) ->
            @tiles = []
            @empty_tiles = []
            @objects = []
            @load()
            @num_creatures = 6

        matrix_sub_area: (matrix, left, top, right, bottom) ->
            (row[left..right - 1] for row in matrix[top..bottom - 1])

        load: ->
            left = @x * g.width
            top = @y * g.height
            right = (@x + 1) * g.width
            bottom = (@y + 1) * g.height

            if left is 0
                right += g.border
            else
                left -= g.border * @x

            if top is 0
                bottom += g.border
            else
                top -= g.border * @y

            @tiles = @matrix_sub_area(g.world, left, top, right, bottom)
            @objects = @matrix_sub_area(g.objects, left, top, right, bottom)
            @obstacles = @matrix_sub_area(g.obstacles, left, top, right, bottom)
            @graph = new pathfinding.Grid(@obstacles[0].length, @obstacles.length, @obstacles)

            for row, y in @tiles
                for cell, x in row
                    @empty_tiles.push(x: x, y: y) unless cell in g.solid_things

    class Scenes
        constructor: ->
            @num = 2
            @pos =
                x: 0
                y: 0
            @scenes = []

            for y in [0..@num - 1]
                @scenes[y] = []
                for x in [0..@num - 1]
                    @scenes[y][x] = new Scene(x, y)

            @set()

        set: ->
            @current = @scenes[@pos.x][@pos.y]

        add_creatures: (Creature) ->
            for column, y in @scenes
                for scene, x in column
                    scene.creatures = (new Creature(null, {x: x, y: y}) for i in [1..scene.num_creatures])

    return new Scenes
)
