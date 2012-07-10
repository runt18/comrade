define(['entity'], (Entity)->
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

        interact: ->
            if not @trade()
                @chat()

)
