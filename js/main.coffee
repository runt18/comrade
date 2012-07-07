require(['jquery', 'player', 'creature'], ($, Player, Creature)->
    window.Creature = Creature
    draw_block = (dx, dy, type)->
        switch type
            when 1 then sx = 1; sy = 1
            when 2 then sx = 2; sy = 1
            when 3 then sx = 3; sy = 1
        ctx.drawImage texture_canvas, sx * tile_size, sy * tile_size, tile_size, tile_size, dx * tile_size, dy * tile_size, tile_size, tile_size

    load_textures = ->
        textures = new Image
        textures.src = 'img/sprites/textures.png'
        window.texture_canvas = $('<canvas>')[0]
        texture_context = texture_canvas.getContext '2d'
        
        textures.onload = ->    
            texture_canvas.height = textures.height
            texture_canvas.width = textures.width

            texture_context.drawImage textures, 0, 0

            load_scene()

            window.player = new Player

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

                        tile = world[player.in_front.y][player.in_front.x]
                        switch tile
                            when 2
                                player.inventory.push new Fishdddwwddwwssssas
                            when 3
                                player.inventory.push new Rock


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

        load_textures()
        animate()
)
