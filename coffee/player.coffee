define(['underscore', 'entity', 'game', 'scene'], (_, Entity, g, s)->
    class Item
        constructor: ->
            @set_stats()

    class Log extends Item
        set_stats: ->
            @name = 'log'
            @id = 5
            @value = 3

    class Fish extends Item
        set_stats: ->
            @name = 'fish'
            @id = 2
            @value = 3

    class Rock extends Item
        set_stats: ->
            @name = 'rock'
            @id = 3
            @value = 3

    class Player extends Entity
        move_scene: ->
            new_scene = false
            for axis, dimension of {x: g.width, y: g.height}
                if @pos[axis] is 0 and @axis is axis and @direction is -1
                    @pos[axis] = dimension
                    s.pos[axis] -= 1
                    new_scene = true
                if @pos[axis] is dimension - 1 and @axis is axis and @direction is 1
                    @pos[axis] = -1
                    s.pos[axis] += 1
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

        attack_creature: ->
            for creature in s.current.creatures
                if @in_front.x is creature.pos.x and @in_front.y is creature.pos.y
                    creature.health -= @attack
                    creature.remove() if creature.health <= 0
                    return true

        gather_resource: ->
            # override the tile if the object is a resource
            tile = if @next_object in g.resource_ids then @next_object else @next_tile

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

        interact: (tick)->
            if tick % 20 is 0
                if s.current.npcs
                    for npc in s.current.npcs
                        if @in_front.x is npc.pos.x and @in_front.y is npc.pos.y
                            npc.interact()
                            return

            return if @attack_creature()

            # if there's no creature in front to attack, see if there's a resource to gather

            if tick % 50 is 0
                @gather_resource()


    new Player
)
