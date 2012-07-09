define(['game'], (g)->

    class Scene
        constructor: (@x, @y)->
            @tiles = []
            @empty_tiles = []
            @objects = []
            @load()
            @num_creatures = 10

        matrix_sub_area: (matrix, x, y, width, height)->
            (row[x..x + width - 1] for row in matrix[y..y + height - 1])

        load: ->
            @tiles = @matrix_sub_area g.world, @x * g.width, @y * g.height, g.width, g.height
            @objects = @matrix_sub_area g.objects, @x * g.width, @y * g.height, g.width, g.height
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

            for x in [0..@num - 1]
                @scenes[x] = []
                for y in [0..@num - 1]
                    @scenes[x][y] = new Scene(x, y)

            @set()

        set: ->
            @current = @scenes[@pos.x][@pos.y]

        add_creatures: (Creature)->
            for row , x in @scenes
                for scene, y in row
                    scene.creatures = (new Creature(null, {x: x, y: y}) for i in [1..scene.num_creatures])


    new Scenes
)
