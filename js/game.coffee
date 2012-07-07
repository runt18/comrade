define(['perlin'], (PerlinNoise)->
    class Game
        constructor: ->
            @num_creatures = 10
            scenes = 2
            @perlin_size = 5
            @width = 30
            @height = 20
            @creatures = []
            @current_scene =
                x: 0
                y: 0
            @world_width = @width * scenes
            @world_height = @height * scenes
            @tile_size = 30
            @screen_width = @width * @tile_size
            @screen_height = @height * @tile_size
            @ctx = null
            @solid_tiles = [2, 3]
            @scene = []
            @empty_tiles = []

            @generate_world()
            @load_scene()

        matrix_sub_area: (matrix, x, y, width, height)->
            (row[x..x + width] for row in matrix[y..y + height])

        generate_world: ->
            world = (@block_type PerlinNoise @perlin_size * x / @world_width, @perlin_size * y / @world_height, .8  for x in [0..@world_width - 1] for y in [0..@world_height - 1])
            world[@world_height - 1] = world[0] = (3 for x in [0..@world_width - 1])
            world[x][@world_width - 1] = world[x][0] = 3 for x in [0..@world_height - 1]
            @world = world

        block_type: (height)->
            return 2 if height  <= .35
            return 1 if .35 < height < .6
            3

        load_scene: ->
            @scene = @matrix_sub_area @world, @current_scene.x * @width, @current_scene.y * @height, @width, @height
            for row, y in @scene
                for cell, x in row
                    @empty_tiles.push(x: x, y: y) unless cell in @solid_tiles

    new Game
)
