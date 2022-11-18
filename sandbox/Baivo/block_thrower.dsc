# Author: Baivo
# Select a block material then spam throw it. Made ages ago and definitely deserves a rework into a real item.

block_thrower:
    type: world
    events:
        on player left clicks block with:diamond_hoe flagged:Baivo:
            - if <player.is_op>:
                - flag player blockThrower:<context.location.material>
                - narrate "<context.location.material.name> will now be thrown with the block thrower."
                - determine cancelled passively
        on player right clicks air with:diamond_hoe flagged:Baivo:
            - if <player.is_op>:
                - shoot falling_block[fallingblock_type=<player.flag[blockthrower]>] origin:<player> speed:3
                - determine cancelled passively
