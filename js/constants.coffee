matrix_sub_area = (matrix, x, y, width, height)->
    (row[x..x + width] for row in matrix[y..y + height])

block_type = (height)->
    return 2 if height <= .3
    return 1 if .3 < height < .7
    3

window.load_scene = ->
    window.scene = matrix_sub_area(world, current_scene.x * width, current_scene.y * height, width, height)
    
window.width = 20
window.height = 20
window.scenes = 2
window.current_scene =
    x: 0
    y: 0
window.world_width = width * scenes
window.world_height = height * scenes
window.tile_size = 20
window.perlin_size = 5
window.screen_width = width * tile_size
window.screen_height = height * tile_size
window.ctx = null
window.solid_tiles = [2, 3]
window.scene = []

window.world = (block_type(PerlinNoise.noise(perlin_size * x / world_width, perlin_size * y / world_height, .8)) for x in [0..world_width - 1] for y in [0..world_height - 1])

 
