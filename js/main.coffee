require(['jquery', 'game', 'scene', 'renderer', 'player', 'creature'], ($, g, s, r, player, Creature)->

    load_textures = ->
        textures = new Image
        textures.src = 'img/textures.png'
        window.texture_canvas = $('<canvas>')[0]
        texture_context = texture_canvas.getContext '2d'

        textures.onload = ->
            texture_canvas.height = textures.height
            texture_canvas.width = textures.width
            texture_context.drawImage textures, 0, 0

            # s.load()
            window.creatures = (new Creature for x in [1..g.num_creatures])

            animate()

    music = null
    load_music = ->
        music = new Audio 'audio/main.ogg'
        # there's a loop property but its not supported everywhere so an event listener is better for now
        music.addEventListener 'ended', ->
            this.currentTime = 0
            this.play()
        , false
        music.muted = true # false for production
        music.play()


    keys_down =
        w: no
        a: no
        s: no
        d: no
        l: no
        k: no

    tick = 0

    render = (time)->
        player.move 'y', -1 if keys_down.w
        player.move 'x', -1 if keys_down.a
        player.move 'y', 1 if keys_down.s
        player.move 'x', 1 if keys_down.d

        if tick % 200 is 0
            if keys_down.l
                creatures.push new Creature x: player.in_front.x, y: player.in_front.y
            if keys_down.k
                player.interact()

        r.clear()
        r.draw_block x, y, tile for tile, x in row for row, y in s.current.tiles
        r.draw_object x, y, object for object, x in row for row, y in s.current.objects

        for creature in creatures
            if tick % 10 is 0
                if Math.random() > 0.9
                    axis = if Math.random() > 0.5 then 'x' else 'y'
                    direction = if Math.random() > 0.5 then 1 else -1
                    creature.move(axis, direction)
            creature.animate()

        player.animate()

        r.draw_inventory(player)

        tick += 1

    animate = (time)->
        requestAnimationFrame animate
        render time

    change_keys = (event)->
        type = event.type
        code = event.which
        is_down = type is 'keydown'

        if code in [87, 65, 83, 68, 75, 76]
            event.preventDefault()
            switch code
                when 87 then keys_down.w = is_down
                when 65 then keys_down.a = is_down
                when 83 then keys_down.s = is_down
                when 68 then keys_down.d = is_down
                when 75 then keys_down.k = is_down
                when 76 then keys_down.l = is_down

        if is_down
            if code is 77
                music.muted = not music.muted

    $(document).ready ->
        r.init()

        $body.keydown change_keys
        $body.keyup change_keys

        load_textures()
        load_music()
)
