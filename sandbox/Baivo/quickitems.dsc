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
        - repeat 25:
            - define fire <[fire].include[<entity[falling_block].with_single[fallingblock_type=fire]>]>
        - shoot <[fire]> spread:25.0

smoker:
    type: item
    material: flint_and_steel
    display name: <&c>Smoker
    lore:
    - <&8><&gt> <&7>Right click to smoke
    - <&7>It's hit to smoke bees

smoker_events:
    type: world
    debug: true
    events:
        on player right clicks block with:smoker:
        # - ratelimit <player> 1t
        - define nests <player.location.find_blocks[bee_nest].within[5]>
        - foreach <[nests]> as:nest:
            - playeffect <[nest].location> effect:smoke_large count:2
            - playsound <[nest].location> sound:block.smoker.smoke.on
            - adjust <[nest]> release_bees