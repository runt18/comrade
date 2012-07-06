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

    keys_down = 
        w: no
        a: no
        s: no
        d: no

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

    $(document).ready ->
        $canvas = $ '<canvas>'
        $body = $ 'body'
        $body.append $canvas
        canvas = $canvas[0]

        canvas.width = screen_width
        canvas.height = screen_height
        window.ctx = canvas.getContext '2d'


        $body.keydown (event)->
            code = event.which
            if code in [87, 65, 83, 68]
                event.preventDefault()
                switch code
                    when 87 then keys_down.w = yes
                    when 65 then keys_down.a = yes
                    when 83 then keys_down.s = yes
                    when 68 then keys_down.d = yes

        $body.keyup (event)->
            code = event.which
            if code in [87, 65, 83, 68]
                event.preventDefault()
                switch code
                    when 87 then keys_down.w = no
                    when 65 then keys_down.a = no
                    when 83 then keys_down.s = no
                    when 68 then keys_down.d = no

        animate()
)
