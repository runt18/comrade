define(['underscore', 'perlin'], (_, PerlinNoise)->
    class Game
        constructor: ->
            # height of the UI below the main game area in pixels
            @ui_height = 30
            # TODO move these to the Scene class
            # width and height of one scene in tiles
            @width = 30
            @height = 20
            # size of one tile in pixels
            @tile_size = 30
            # width and height of the entire game screen in pixels
            @screen_width = @width * @tile_size
            @screen_height = @height * @tile_size + @ui_height

            # height and width of the whole world in tiles
            @world_width = @width * 2
            @world_height = @height * 2

            # number of trees in the world
            @num_trees = 100

            # values for controlling the output of the Perlin noise function
            @perlin_size = 5
            @perlin_z_axis = .8

            # IDs of tiles and objects that entities cannot walk through
            @solid_things = [2, 3, 5]
            @resource_ids = [2, 3, 5]

            # array of coordinate pairs specifying tiles not occupied by solid tiles or objects
            @empty_tiles = []

            # 2d array of IDs of objects (trees etc.)
            @objects = (0 for x in [0..@world_width - 1] for y in [0..@world_height - 1])
            # 2d array of IDs of tiles (grass, water etc.)
            @world = (3 for x in [0..@world_width - 1] for y in [0..@world_height - 1])

            @generate_world()
            @add_trees()

        add_trees: ->
            potential_trees = _.clone(@empty_tiles)
            trees = []
            for i in [1..@num_trees]
                index = Math.floor Math.random() * potential_trees.length
                trees.push(potential_trees.splice(index, 1)[0])

            for tree in trees
                @objects[tree.y][tree.x] = 5

        generate_world: ->
            for y in [1..@world_height - 2]
                for x in [1..@world_width - 2]
                    tile = @block_type PerlinNoise @perlin_size * x / @world_width, @perlin_size * y / @world_height, @perlin_z_axis
                    @world[y][x] = tile
                    @empty_tiles.push(x: x, y: y) unless tile in @solid_things

        block_type: (height)->
            return 2 if height <= .3
            return 4 if .3 < height <= .4
            return 1 if .4 < height <= .7
            3


    new Game
)
