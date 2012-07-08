define(['jquery', 'game'], ($, g)->
    class Renderer
        init: ->
            $canvas = $ '<canvas>'
            window.$body = $ 'body'
            $('#game').html $canvas
            canvas = $canvas[0]

            canvas.width = g.screen_width
            canvas.height = g.screen_height

            @ctx = canvas.getContext '2d'

        clear: ->
            @ctx.clearRect 0, 0, g.screen_width, g.screen_height

        draw_texture: (sx, sy, dx, dy)->
            ts = g.tile_size
            @ctx.drawImage texture_canvas, sx * ts, sy * ts, ts, ts, dx * ts, dy * ts, ts, ts

        draw_block: (dx, dy, type)->
            sy = 1
            switch type
                when 1 then sx = 1
                when 2 then sx = 2
                when 3 then sx = 3
                when 4 then sx = 4
            @draw_texture sx, sy, dx, dy

        draw_object: (dx, dy, type)->
            return if type is 0
            sy = 5
            sx = type
            @draw_texture sx, sy, dx, dy

        draw_health_bar: (value, max)->
            height = 20
            @ctx.fillStyle = @ctx.strokeStyle = 'red'
            @ctx.strokeRect g.screen_width - 200, g.screen_height - 25, 100, height
            @ctx.fillRect g.screen_width - 200, g.screen_height - 25, 100 * value / max, height

        draw_coins: (num)->
            @draw_texture 4, 3, 29, 20
            @ctx.fillText num, g.screen_width - 40, g.screen_height - 10
            

        draw_inventory: (player)->
            @ctx.fillStyle = 'grey'
            @ctx.fillRect 0, g.screen_height - g.ui_height, g.screen_width, g.screen_height
            @ctx.fillStyle = 'white'
            
            ts = g.tile_size
            for slot, x in player.inventory
                sy = 3
                switch slot.item.id
                    when 1 then sx = 1
                    when 2 then sx = 2
                    when 3 then sx = 3
                
                # @ctx.fillRect x * ts, g.screen_height - g.ui_height, (x + 1) * ts, g.screen_height
                if slot.count > 0
                    @draw_texture sx, sy, x, (g.screen_height - g.ui_height) / g.tile_size
                    @ctx.fillText slot.count, x * ts + 30, g.screen_height - 10

            @draw_coins(player.coins)
            @draw_health_bar player.health, player.max_health
            

    new Renderer
)
