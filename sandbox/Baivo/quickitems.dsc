
flammen_thrower:
    type: item
    material: flint_and_steel
    display name: <&c>Flammen Thrower
    lore:
    - <&8><&gt> <&7>Right click to werfe flames

flammen_thrower_events:
    type: world
    events:
        on player right clicks block with:flammen_thrower:
        # - ratelimit <player> 1t
        - define fire <list>
        - repeat 5:
            - define fire <[fire].include[<entity[falling_block].with_single[fallingblock_type=fire]>]>
        - shoot <[fire]> spread:5.0