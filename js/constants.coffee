define(['perlin'], (PerlinNoise)->
    matrix_sub_area = (matrix, x, y, width, height)->
        (row[x..x + width] for row in matrix[y..y + height])

    block_type = (height)->
        return 2 if height  <= .35
        return 1 if .35 < height < .6
        3

    window.load_scene = ->
        window.scene = matrix_sub_area world, current_scene.x * width, current_scene.y * height, width, height
        for row, y in window.scene
            for cell, x in row
                debugger
                window.empty_tiles.push([x, y]) unless cell in window.solid_tiles

    window.width = 20
    window.height = 20
    scenes = 2
    window.current_scene =
        x: 0
        y: 0
    window.world_width = width * scenes
    window.world_height = height * scenes
    window.tile_size = 20
    perlin_size = 5
    window.screen_width = width * tile_size
    window.screen_height = height * tile_size
    window.ctx = null
    window.solid_tiles = [2, 3]
    window.scene = []
    window.empty_tiles = []

    world = (block_type PerlinNoise perlin_size * x / world_width, perlin_size * y / world_height, .8  for x in [0..world_width - 1] for y in [0..world_height - 1])
    world[world_height - 1] = world[0] = (3 for x in [0..world_width - 1])
    world[x][world_width - 1] = world[x][0] = 3 for x in [0..world_height - 1]
    window.world = world
    
)
