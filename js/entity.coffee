define(['constants'], ->
    class Entity
        constructor: (pos)->
            @pos = pos
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

        set_position: ->
            @pos = @pos or empty_tiles[Math.round Math.random() * empty_tiles.length]

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

            @draw()

        move: (axis, direction)->
            # Don't do anything if it's currently moving
            return if @frames_left > 0

            # Snap to nearest grid square
            @pos.x = Math.round @pos.x
            @pos.y = Math.round @pos.y

            # Set the axis and direction and update the image to refect this
            @axis = axis
            @direction = direction
            @set_image()
            
            # Move to a new scene if it's moving off the edge of the current one
            @move_scene()

            # Update the coordinates of the square in front
            @set_in_front()

            # Calculate the contents of the tile that it's trying to move to
            if axis is 'x'
                next_tile = scene[@pos.y][@pos.x + direction]
            if axis is 'y'
                next_tile = scene[@pos.y + direction][@pos.x] 
            
            # Let it move if the tile isn't water or rock or something    
            @frames_left = 10 unless next_tile in solid_tiles

    return Entity
)
