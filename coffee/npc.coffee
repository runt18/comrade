define(['entity'], (Entity)->
	class NPC extends Entity
        say: ->
        	$dialogue = $ '#dialogue'
        	phrase = @phrases[@phrase_index]
        	$dialogue.append $('<p>').text "#{@name}: #{phrase}"
        	$dialogue.scrollTop $dialogue[0].scrollHeight
        	@phrase_index += 1
        	@phrase_index = 0 if @phrase_index is @phrases.length

)
