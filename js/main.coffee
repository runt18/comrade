require(['jquery', 'keymaster', 'entity'], ($, key, Entities)->
    Player = Entities.Player
    Creature = Entities.Creature
    
    draw_block = (x, y, type)->
        # log(type)
        switch type
            when 1 then ctx.fillStyle = 'green'
            when 2 then ctx.fillStyle = 'blue'
            when 3 then ctx.fillStyle = 'brown'
        ctx.fillRect x * tile_size, y * tile_size, tile_size, tile_size

    player = new Player
    num_creatures = 10
    creatures = (new Creature for x in [1..num_creatures])

    load_scene()

    key('w', ->
        player.move('y', -1)
    )

    key('a', ->
        player.move('x', -1)
    )

    key('s', ->
        player.move('y', 1)
    )

    key('d', ->
        player.move('x', 1)
    )

    key('l', ->
        creatures.push new Creature player.in_front.x, player.in_front.y
    )

    key('k', ->
        for creature in creatures
            # debugger

            if Math.round player.in_front.x is Math.round creature.pos.x and Math.round player.in_front.y is Math.round creature.pos.y
                debugger
                creatures.splice creatures.indexOf creature
    )

    key('f', ->
        current_scene.x = if current_scene.x is 0 then 1 else 0
        load_scene()
    )

    tick = 0

    render = (time)->
        ctx.clearRect 0, 0, screen_width, screen_height
        draw_block x, y, tile for tile, x in row for row, y in scene
        
        for creature in creatures
            if tick % 10 is 0
                if Math.random() > 0.9
                    axis = if Math.random() > 0.5 then 'x' else 'y'
                    direction = if Math.random() > 0.5 then 1 else -1
                    creature.move(axis, direction)
            creature.animate()
        
        player.animate()

        tick += 1

    animate = (time)->
        requestAnimationFrame animate
        render time

    $(document).ready ->
        $canvas = $ '<canvas>'
        $('body').append $canvas
        canvas = $canvas[0]

        canvas.width = screen_width
        canvas.height = screen_height
        window.ctx = canvas.getContext '2d'

        animate()
)
