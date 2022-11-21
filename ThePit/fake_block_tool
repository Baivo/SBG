# Author: Baivo
# I'm fairly certain this single script is the reason Tink divorced me.

fallingblock:
    type: world
    events:
        on player left clicks block with:fakeblockstool:
            - ratelimit <player> 3t
            - define block <player.eye_location.ray_trace[return=block]||null>
            - define type <[block].material.name>
            - modifyblock <[block]> air
            - spawn falling_block[fallingblock_type=<[type]>;gravity=false] <[block].center.below[0.5]> save:fallingblock
            - define fallingblock <entry[fallingblock].spawned_entity>
            - adjust <[fallingblock]> auto_expire:false
        on player right clicks falling_block with:fakeblockstool:
            - remove <context.entity>

fakeblockstool:
    type: item
    material: blaze_rod
