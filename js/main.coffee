require(['jquery', 'player', 'creature'], ($, Player, Creature)->
    window.Creature = Creature
    draw_block = (x, y, type)->
        switch type
            when 1 then image = grass
            when 2 then image = water
            when 3 then image = water   
        ctx.drawImage(image, x * tile_size, y * tile_size)

    load_scene()

    grass = new Image
    water = new Image
    grass.src = 'img/sprites/grass.png'
    water.src = 'img/sprites/water.png'

    player = new Player

    keys_down = 
        w: no
        a: no
        s: no
        d: no
        l: no

    tick = 0

    render = (time)->
        player.move 'y', -1 if keys_down.w
        player.move 'x', -1 if keys_down.a
        player.move 'y', 1 if keys_down.s
        player.move 'x', 1 if keys_down.d

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

    change_keys = (event)->
        type = event.type
        code = event.which
        is_down = type is 'keydown'
        
        if code in [87, 65, 83, 68, 76]
            event.preventDefault()
            switch code
                when 87 then keys_down.w = is_down
                when 65 then keys_down.a = is_down
                when 83 then keys_down.s = is_down
                when 68 then keys_down.d = is_down

        if is_down
            if code in [75, 76]
                event.preventDefault()
                switch code
                    when 76
                        c = new Creature x: player.in_front.x, y: player.in_front.y
                        c.add()
                    when 75
                        for creature in creatures
                            if player.in_front.x is creature.pos.x and player.in_front.y is creature.pos.y
                                creature.health -= player.attack
                                creature.remove() if creature.health <= 0


    $(document).ready ->
        $canvas = $ '<canvas>'
        $body = $ 'body'
        $('#game').html $canvas
        canvas = $canvas[0]

        canvas.width = screen_width
        canvas.height = screen_height
        window.ctx = canvas.getContext '2d'

        $body.keydown change_keys

        $body.keyup change_keys

        animate()
)
