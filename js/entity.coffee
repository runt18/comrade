define(['constants'], ->
    class Entity
        constructor: (x, y)->
            @x = x
            @y = y
            @images =
                up: new Image()
                left: new Image()
                down: new Image()
                right: new Image()
            
            for direction in 'up left down right'.split ' '
                @images[direction].src = "img/sprites/player/#{ direction }.png"

            @image = @images.down

            @frames_left = 0
            @set_position()
            @axis = 'x'
            @direction = 1
            @set_in_front()

        set_image: ->
            switch @axis
                when 'x'
                    image = if @direction is 1 then 'right' else 'left'
                when 'y'
                    image = if @direction is 1 then 'down' else 'up'
            
            @image = @images[image]

        set_in_front: ->
            switch @axis
                when 'x' then @in_front = x: @pos.x + @direction * 2, y: @pos.y
                when 'y' then @in_front = x: @pos.x, y: @pos.y + @direction * 2

        draw: ->
            ctx.drawImage @image, @pos.x * tile_size, @pos.y * tile_size, tile_size, tile_size

        animate: ->
            if @frames_left > 0
                @pos[@axis] += @direction * 0.1
                @frames_left -= 1
            else
                @pos.x = Math.round @pos.x
                @pos.y = Math.round @pos.y
            @draw()

        move: (axis, direction)->
            return if @frames_left > 0

            @axis = axis
            @direction = direction
            @set_image()
            
            @move_scene()

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
        set_position: ->
            @pos =
                x: width / 2
                y: height / 2

        move_scene: ->
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


    class Creature extends Entity
        set_position: ->
            @pos =
                x: @x or Math.floor Math.random() * width
                y: @y or Math.floor Math.random() * height

        move_scene: ->

    {Player: Player, Creature: Creature}
)
