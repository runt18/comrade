define([], ->
    class Entity
        constructor: ->
            @colour = 'red'
            @frames_left = 0
            @pos =
                x: width / 2
                y: height / 2
            @axis = 'x'
            @direction = 1
            @set_in_front()

        set_colour: (colour)->
            @colour = colour

        set_in_front: ->
            switch @axis
                when 'x' then @in_front = x: @pos.x + @direction * 2, y: @pos.y
                when 'y' then @in_front = x: @pos.x, y: @pos.y + @direction * 2

        draw: ->
            ctx.fillStyle = @colour
            ctx.fillRect @pos.x * tile_size, @pos.y * tile_size, tile_size, tile_size

        animate: ->
            if @frames_left > 0
                @pos[@axis] += @direction * 0.1
                @frames_left -= 1
            else
                @pos.x = Math.round @pos.x
                @pos.y = Math.round @pos.y
            @draw()

        move: ->    
            try
                next_tile = scene[@in_front.y][@in_front.x]
                # log next_tile
            catch TypeError
                # log 'edge'

            @set_in_front()

            debugger
            @frames_left = 10
            if next_tile in solid_tiles
                @frames_left = 0

    class Player extends Entity
        move: ->
            new_scene = false
            for item in [{axis: 'x', dimension: width}, {axis: 'y', dimension: height}]
                if @pos[item.axis] is 0 and @axis is item.axis and @direction is -1
                    @pos[item.axis] = item.dimension
                    current_scene[item.axis] -= 1
                    new_scene = true
                if @pos[item.axis] is item.dimension - 1 and @axis is item.axis and @direction is 1
                    @pos[item.axis] = -1
                    current_scene[item.axis] += 1
                    new_scene = true

            load_scene() if new_scene

            try
                next_tile = scene[@in_front.y][@in_front.x]
                # log next_tile
            catch TypeError
                # log 'edge'

            @set_in_front()

            debugger
            @frames_left = 10
            if next_tile in solid_tiles
                @frames_left = 0

    class Creature extends Entity
        constructor: (x, y)->
            @colour = 'purple'
            @frames_left = 0
            @pos =
                x: x or Math.floor Math.random() * width
                y: y or Math.floor Math.random() * height
            @axis = 'x'
            @direction = 1
            @set_in_front()

    return {Player: Player, Creature: Creature}

)
