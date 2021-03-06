require(
    ['jquery', 'game', 'scene', 'renderer',
    'player', 'creature', 'wizard', 'lumberjack', 'fisherman'
    'stats'],
($, g, s, r, player, Creature, wizard, Lumberjack, Fisherman, Stats)->

    load_textures = ->
        textures = new Image
        textures.src = 'img/textures.png'
        window.texture_canvas = $('<canvas>')[0]
        texture_context = texture_canvas.getContext '2d'

        textures.onload = ->
            texture_canvas.height = textures.height
            texture_canvas.width = textures.width
            texture_context.drawImage textures, 0, 0

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
        stats.begin()

        player.move 'y', -1 if keys_down.w
        player.move 'x', -1 if keys_down.a
        player.move 'y', 1 if keys_down.s
        player.move 'x', 1 if keys_down.d

        if keys_down.l
            if tick % 20 is 0
                s.current.creatures.push new Creature x: player.in_front.x, y: player.in_front.y
        if keys_down.k
            player.interact(tick)

        r.clear()
        r.draw_block x, y, tile for tile, y in column for column, x in s.current.tiles
        r.draw_object x, y, object for object, y in column for column, x in s.current.objects

        for creature in s.current.creatures
            if tick % 10 is 0
                # if Math.random() > 0.9
                #     axis = if Math.random() > 0.5 then 'x' else 'y'
                #     direction = if Math.random() > 0.5 then 1 else -1
                #     creature.move(axis, direction)
                if creature.moving_along_path
                    creature.move_along_path()
                else
                    if Math.random() > 0.9
                        creature.pathfind({x: 10, y: 10})

            creature.animate()

        if s.current.npcs
            for npc in s.current.npcs
                npc.animate()

        player.animate()

        r.draw_inventory(player)

        tick += 1

        stats.end()

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

    stats = null
    $(document).ready ->
        r.init()

        s.add_creatures(Creature)
        lumberjack = new Lumberjack
        fisherman = new Fisherman
        s.current.npcs = [wizard, lumberjack, fisherman]

        $body.keydown change_keys
        $body.keyup change_keys
        $('#response').keyup (event)->
            if event.which is 13
                for npc in s.current.npcs
                    if npc.selling
                        npc.sell_to parseInt $(this).val()
                        break

        load_textures()
        load_music()

        stats = new Stats

        $(stats.domElement).addClass('stats').appendTo($body)
)
