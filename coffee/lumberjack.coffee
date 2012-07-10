define(['underscore', 'npc', 'player'], (_, NPC, player)->
	class Lumberjack extends NPC
		move_scene: ->

		create_images: ->
            @images =
                up: x: 9, y: 2
                left: x: 11, y: 2
                down: x: 10, y: 2
                right: x: 12, y: 2

        set_stats: ->
        	@name = 'Lumberjack'
        	@phrases = [
                "Choppin' logs is a good way to make a livin'."
                "How d'you like our little town?"
            ]
            @phrase_index = 0
            @selling = false

        trade: ->
            @logs = _.find player.inventory, (slot)-> slot.item.id is 5
            if @logs
                @say "Looks like you've collected some logs"
                @say "I'll buy them from you for 3 gold each"
                @say "How many would you like to sell?"
                @selling = true
                return true

        sell_to: (num)->
            # log @logs
            if @logs.count < num
                @say "Sorry, you only have #{@logs.count} logs"
            else
                @logs.count -= num
                player.coins += num * @logs.item.value
                $('#response').val ''
            @selling = false


)
