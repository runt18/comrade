define(['underscore', 'entity', 'player'], (_, Entity, player)->
	class NPC extends Entity
        chat: ->
            phrase = @phrases[@phrase_index]
            @say phrase
            @phrase_index += 1
            @phrase_index = 0 if @phrase_index is @phrases.length

        say: (message)->
            # return if not message
        	$dialogue = $ '#dialogue'
        	$dialogue.append $('<p>').text "#{@name}: #{message}"
        	$dialogue.scrollTop $dialogue[0].scrollHeight

        trade: ->
            @slot = _.find player.inventory, (slot)=> slot.item.id is @item_id
            if @slot
                @say "Looks like you've collected some #{@slot.item.name}"
                @say "I'll buy them from you for #{@slot.item.value} gold each"
                @say "How many would you like to sell?"
                @selling = true
                return true

        sell_to: (num)->
            if @slot.count < num
                # TODO: plural formatting
                @say "Sorry, you only have #{@slot.count} #{@slot.item.name}"
            else
                @slot.count -= num
                player.coins += num * @slot.item.value
                $('#response').val ''
                @say "Nice doing business with you"
            @selling = false

        interact: ->
            if not @trade()
                @chat()

)
