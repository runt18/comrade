define(['game'], (g)->

    class Scene
        constructor: (@x, @y)->
            @tiles = []
            @empty_tiles = []
            @objects = []
            @load()
            @num_creatures = 10

        matrix_sub_area: (matrix, left, top, right, bottom)->
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
            else top -= g.border * @y
            # right += 1 if right isnt g.world_width
            # top -= 1 if top isnt 0
            # bottom += 1 if bottom isnt g.world_height

            @tiles = @matrix_sub_area g.world, left, top, right, bottom
            @objects = @matrix_sub_area g.objects, left, top, right, bottom
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
