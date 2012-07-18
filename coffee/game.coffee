define(['perlin'], (PerlinNoise)->
    class Game
        constructor: ->
            @name = 'Comrade'

            # height of the UI below the main game area in pixels
            @ui_height = 30

            # number of tiles overlap between scenes
            @border = 1
            # id of tile that surrounds the entire world to stop entities going outside the world
            border_tile = 2

            # TODO move these to the Scene class
            # width and height of one scene in tiles
            @width = 20 + @border
            @height = 20 + @border
            # size of one tile in pixels
            @tile_size = 30

            # width and height of the entire game screen in pixels
            @screen_width = @width * @tile_size
            @screen_height = @height * @tile_size + @ui_height

            # height and width of the whole world in tiles
            @_num_scenes = 2
            @world_width = (@width * @_num_scenes) - @_num_scenes + 1
            @world_height = (@height * @_num_scenes) - @_num_scenes + 1

            # number of trees in the world
            @num_trees = 100

            # values for controlling the output of the Perlin noise function
            @perlin_size = 5
            @perlin_z_axis = .8
            @input = null

            # IDs of tiles and objects that entities cannot walk through
            @solid_things = [2, 3, 5]
            @resource_ids = [2, 3, 5]

            # array of coordinate pairs specifying tiles not occupied by solid tiles or objects
            @empty_tiles = []

            # 2d array of IDs of objects (trees etc.)
            @objects = (0 for y in [0..@world_height - 1] for x in [0..@world_width - 1])

            @obstacles = (0 for y in [0..@world_height - 1] for x in [0..@world_width - 1])
            # 2d array of IDs of tiles (grass, water etc.)
            @world = (border_tile for y in [0..@world_height - 1] for x in [0..@world_width - 1])

            @generate_world()
            @add_trees()

        add_trees: ->
            for i in [1..@num_trees]
                index = Math.floor Math.random() * @empty_tiles.length
                tree = @empty_tiles.splice(index, 1)[0]
                @objects[tree.x][tree.y] = 5
                @obstacles[tree.x][tree.y] = 1

        generate_world: ->
            for x in [1..@world_width - 2]
                for y in [1..@world_height - 2]
                    tile = @block_type PerlinNoise @perlin_size * x / @world_width, @perlin_size * y / @world_height, @perlin_z_axis
                    @world[x][y] = tile
                    unless tile in @solid_things
                        @empty_tiles.push(x: x, y: y)
                        @obstacles[x][y] = 1

        block_type: (height)->
            return 2 if height <= .3
            return 4 if .3 < height <= .4
            return 1 if .4 < height <= .7
            3


    new Game
)
