define(['entity', 'game'], (Entity, g)->

    class Player extends Entity
        move_scene: ->
            new_scene = false
            for item in [{axis: 'x', dimension: g.width}, {axis: 'y', dimension: g.height}]
                if @pos[item.axis] is 0 and @axis is item.axis and @direction is -1
                    @pos[item.axis] = item.dimension
                    g.current_scene[item.axis] -= 1
                    new_scene = true
                if @pos[item.axis] is item.dimension - 1 and @axis is item.axis and @direction is 1
                    @pos[item.axis] = -1
                    g.current_scene[item.axis] += 1
                    new_scene = true

            g.load_scene() if new_scene

        set_stats: ->
            @health = 10
            @attack = 2

        interact: ->
            for creature in creatures
                if @in_front.x is creature.pos.x and @in_front.y is creature.pos.y
                    creature.health -= @attack
                    creature.remove() if creature.health <= 0

            tile = g.world[@in_front.y][@in_front.x]
            switch tile
                when 2
                    @inventory.push new Fish
                when 3
                    @inventory.push new Rock

    new Player
)
