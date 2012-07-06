define(['entity'], (Entity)->

    class Player extends Entity
        move_scene: ->
            new_scene = false
            for item in [{axis: 'x', dimension: width}, {axis: 'y', dimension: height}]
                if @pos[item.axis] is 0 and @axis is item.axis and @direction is -1
                    @pos[item.axis] = item.dimension
                    current_scene[item.axis] -= 1
                    new_scene = true
                if @pos[item.axis] is item.dimension - 1 and @axis is item.axis and @direction is 1
                    @pos[item.axis] = -1
                    current_scene[item.axis] += 1
                    new_scene = true

            load_scene() if new_scene

    return Player

)
