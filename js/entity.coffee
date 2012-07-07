define(['game'], (g)->
    class Entity
        constructor: (@pos)->
            @images =
                up: x: 1, y: 2
                left: x: 3, y: 2
                down: x: 2, y: 2
                right: x: 4, y: 2
            
            @image = @images.down

            @frames_left = 0
            @set_position()
            @axis = 'x'
            @direction = 1
            @set_in_front()
            @set_stats()
            @inventory = []

        set_position: ->
            @pos = @pos or g.empty_tiles[Math.round Math.random() * g.empty_tiles.length]

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

        snap_to_grid: ->
            # Snap to nearest grid square when the animation has finished
            @pos.x = Math.round @pos.x
            @pos.y = Math.round @pos.y

        draw: ->
            ts = g.tile_size
            g.ctx.drawImage texture_canvas, ts * @image.x, ts * @image.y, ts, ts, @pos.x * ts, @pos.y * ts, ts, ts

        animate: ->
            if @frames_left > 0
                @pos[@axis] += @direction * 0.1
                @frames_left -= 1
            else
                @snap_to_grid()

            @draw()

        move: (axis, direction)->
            # Don't do anything if it's currently moving
            return if @frames_left > 0
            
            @snap_to_grid()

            # Set the axis and direction and update the image to refect this
            @axis = axis
            @direction = direction
            @set_image()
            
            # Move to a new scene if it's moving off the edge of the current one
            @move_scene()

            # Update the coordinates of the square in front
            @set_in_front()

            try
                # Calculate the contents of the tile that it's trying to move to
                if axis is 'x'
                    next_tile = g.scene[@pos.y][@pos.x + direction]
                if axis is 'y'
                    next_tile = g.scene[@pos.y + direction][@pos.x] 
                
                # Let it move if the tile isn't water or rock or something    
                @frames_left = 10 unless next_tile in g.solid_tiles
            catch TypeError

)
