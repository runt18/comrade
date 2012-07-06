define(['entity'], (Entity)->

    class Creature extends Entity
        move_scene: ->
        remove: ->
            creatures.splice creatures.indexOf(this), 1
        add: ->
        	creatures.push this

        set_stats: ->
        	@health = 5
        	@attack = 1


    return Creature

)
