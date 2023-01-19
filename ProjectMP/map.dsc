# capture all blocks within a 16 block radius from the player
        # store them into a grid of 16x16 blocks (256 blocks)
        # grid is a map location is the block location and material is the block material
        # grid is used to construct the 16x16 grid of blocks as text in chat for the player
        # each block is represented by a single uniqode square ■
        # using the material of the block to determine the color of the square
        # color is a hex value of the material's texture color on it's surface
        # each tick, the grid is updated and sent to the player in chat
        # the grid is refreshed each tick so the player can see the blocks change as they walk around
chat_map:
    type: world
    events:
        on player steps on block:
        - ratelimit <player> 1t
        - define location <player.location.relative[8,0,8]>
        - define grid <map>
        - repeat 16:
            - repeat 16:
                - define grid <[grid].with[<[location]>].as[<[location].material.name>]>
                - define location <[location].relative[-1,0,0]>
            - define location <[location].relative[16,0,-1]>
        - foreach <[grid]> key:<[pixel]> as:<[material]>:
            - define color <[material]>