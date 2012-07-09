define(['underscore', 'entity', 'game', 'scene'], (_, Entity, g, s)->
    class Item
        constructor: ->
            @set_id()

    class Log extends Item
        set_id: -> @id = 5

    class Fish extends Item
        set_id: -> @id = 2

    class Rock extends Item
        set_id: -> @id = 3

    class Player extends Entity
        move_scene: ->
            new_scene = false
            for item in [{axis: 'x', dimension: g.width}, {axis: 'y', dimension: g.height}]
                if @pos[item.axis] is 0 and @axis is item.axis and @direction is -1
                    @pos[item.axis] = item.dimension
                    s.pos[item.axis] -= 1
                    new_scene = true
                if @pos[item.axis] is item.dimension - 1 and @axis is item.axis and @direction is 1
                    @pos[item.axis] = -1
                    s.pos[item.axis] += 1
                    new_scene = true

            s.set() if new_scene

        create_images: ->
            @images =
                up: x: 1, y: 2
                left: x: 3, y: 2
                down: x: 2, y: 2
                right: x: 4, y: 2

        set_stats: ->
            @max_health = 10
            @health = @max_health - 5
            @attack = 2
            @coins = 0

        interact: ->
            if s.current.wizard
                wizard = s.current.wizard

                if @in_front.x is wizard.pos.x and @in_front.y is wizard.pos.y
                    wizard.say()
                    return

            for creature in s.current.creatures
                if @in_front.x is creature.pos.x and @in_front.y is creature.pos.y
                    creature.health -= @attack
                    creature.remove() if creature.health <= 0
                    return

            # if there's no creature in front to attack, see if there's a resource to gather

            # get the tile an object at the square in front of the player
            tile = @next_tile
            object = @next_object

            # override the tile if the object is a resource
            tile = object if object in g.resource_ids

            # don't do anything if the tile isn't a resource, eg grass
            return unless tile in g.resource_ids

            # if the item is already in the players inventory, increase its count by 1
            already_present = false
            for slot in @inventory
                if slot.item.id is tile
                    already_present = true
                    slot.count += 1
                    break

            # if it's not, find the first free slot and add it there
            if not already_present
                free_slots = false
                for slot in @inventory
                    if slot.count is 0
                        slot.count = 1
                        free_slots = true
                        switch tile
                            when 5 then slot.item = new Log
                            when 2 then slot.item = new Fish
                            when 3 then slot.item = new Rock
                        break

                # there are no free slots
                if not free_slots
                    log 'inventory full'

    new Player
)
