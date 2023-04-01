
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
        - ratelimit <player> 1t
        - shoot <entity[falling_block].with_single[fallingblock_type=fire]>