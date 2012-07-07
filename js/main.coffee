require(['jquery', 'game', 'player', 'creature'], ($, g, player, Creature)->
    draw_block = (dx, dy, type)->
        switch type
            when 1 then sx = 1; sy = 1
            when 2 then sx = 2; sy = 1
            when 3 then sx = 3; sy = 1
        ts = g.tile_size
        g.ctx.drawImage texture_canvas, sx * ts, sy * ts, ts, ts, dx * ts, dy * ts, ts, ts

    load_textures = ->
        textures = new Image
        textures.src = 'img/sprites/textures.png'
        window.texture_canvas = $('<canvas>')[0]
        texture_context = texture_canvas.getContext '2d'
        
        textures.onload = ->    
            texture_canvas.height = textures.height
            texture_canvas.width = textures.width
            texture_context.drawImage textures, 0, 0

            g.load_scene()
            window.creatures = (new Creature for x in [1..g.num_creatures])

            animate()


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

        g.ctx.clearRect 0, 0, g.screen_width, g.screen_height
        draw_block x, y, tile for tile, x in row for row, y in g.scene
        
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
                        creatures.push new Creature x: player.in_front.x, y: player.in_front.y         
                    when 75
                        player.interact()

    $(document).ready ->
        $canvas = $ '<canvas>'
        $body = $ 'body'
        $('#game').html $canvas
        canvas = $canvas[0]

        canvas.width = g.screen_width
        canvas.height = g.screen_height
        g.ctx = canvas.getContext '2d'
        
        $body.keydown change_keys
        $body.keyup change_keys

        load_textures()
)
