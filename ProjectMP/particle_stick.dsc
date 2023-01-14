particle_stick:
    type: item
    material: stick
    mechanisms:
        custom_model_data: 17
    display name: <&a>Particle Stick
    lore:
    - Right click to place particles
    - Left click to remove particles
    - Throw (Q) to change particle type
    flags:
        particle: SPELL_WITCH
        particle_count: 10
        particle_animation: circle

particle_stick_events:
    type: world
    events:
        on player right clicks block with:particle_stick:
        - determine cancelled passively
        - define location <context.relative>
        - define id <util.random_uuid>
        - flag server particle_stick_location:->:<[location]>
        - flag <[location]> particle:->:<[id]>
        - flag <[location]> particle.<[id]>.owner:<player.name>
        - flag <[location]> particle.<[id]>.particle:<player.item_in_hand.flag[particle]>
        - flag <[location]> particle.<[id]>.count:<player.item_in_hand.flag[particle_count]>
        - flag <[location]> particle.<[id]>.animation:<player.item_in_hand.flag[particle_animation]>
        on player left clicks block with:particle_stick:
        - determine cancelled passively
        - define location <context.relative>
        - flag server particle_stick_location:<-:<[location]>
        - flag <[location]> particle:!
        on player drops particle_stick:
        - determine cancelled passively
        - inventory open d:<inventory[particle_inventory]>

sparkle:
    type: world
    debug: true
    events:
        on delta time secondly:
        - foreach <server.flag[particle_stick_location].if_null[<list>]> as:location:
            - foreach <[location].flag[particle]> as:id:
                - if <[id].get[animation]> == sparkle:
                    - playeffect at:<[location]> effect:<[id].get[particle]> count:<[id].get[count]> offset:0.5,0.5,0.5 speed:0.5
                - else:
                    - foreach next

circle:
    type: world
    debug: true
    events:
        on delta time secondly:
        - repeat 10:
            - wait 1t
            - foreach <server.flag[particle_stick_location].if_null[<list>]> as:location:
                - foreach <[location].flag[particle]> as:id:
                    - if <[id].get[animation]> == circle:
                        - foreach <[location].points_around_x[radius=0.5;points=12]> as:loc:
                            - playeffect at:<[loc].center> effect:<[id].get[particle]> count:<[id].get[count]> offset:0 speed:0.5
                    - else:
                        - foreach next

particle_inventory:
    type: inventory
    title: Particle Menu
    inventory: chest
    size: 54
    procedural items:
        - define list <list>
        - foreach <server.particle_types> as:particle:
            - define item <item[stick]>
            - define item <[item].with[display name=<&c><[particle]>]>
            - define item <[item].with[lore=<list[<&a>Click to select this particle]>]>
            - define item <[item].with_flag[particle:<[particle]>]>
            - define list <[list].include[<[item]>]>
        - determine <[list]>
