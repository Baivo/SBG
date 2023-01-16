particle_stick:
    type: item
    material: stick
    mechanisms:
        custom_model_data: 17
    display name: <&e>Particle Stick
    lore:
    - <&8>
    - <&7>Right click to place particles
    - <&7>Left click to remove particles
    - <&7>Throw (Q) to change particle type
    flags:
        particle: SPELL_WITCH
        particle_count: 10
        particle_animation: circle

ps_item_events:
    type: world
    events:
        on player right clicks block with:particle_stick:
        - ratelimit <player> 2t
        - determine cancelled passively
        - define location <context.relative>
        - define id <util.random_uuid>
        - flag server particle_stick_location:->:<[location]>
        - flag <[location]> particle:->:<[id]>
        - flag <[location]> particle.<[id]>.owner:<player.name>
        - flag <[location]> particle.<[id]>.particle:<player.item_in_hand.flag[particle]>
        - flag <[location]> particle.<[id]>.count:<player.item_in_hand.flag[particle_count]>
        - flag <[location]> particle.<[id]>.animation:<player.item_in_hand.flag[particle_animation]>
        - narrate "Placed particle at <[location]>"
        on player left clicks block with:particle_stick:
        - determine cancelled passively
        - define location <context.relative>
        - flag server particle_stick_location:<-:<[location]>
        - flag <[location]> particle:!
        on player drops particle_stick:
        - determine cancelled passively
        - inventory open d:<inventory[ps_particle_inventory_1]>
        

ps_ticker:
    type: world
    debug: false
    events:
        on delta time secondly:
        - foreach <server.flag[particle_stick_location].if_null[<list>]> as:location:
            - run ps_ticker2 def.location:<[location]>
            
ps_ticker2:
    type: task
    definitions: location
    script:
        - foreach <[location].flag[particle]> as:id:
            - ~run ps_shape_<[id].get[animation]> def.location:<[location]> def.particle:<[id].get[particle]> def.count:<[id].get[count]>
                    
ps_shape_sparkle:
    type: task
    definitions: location|particle|count
    script:
    - playeffect at:<[location].center> effect:<[particle]> count:<[count]> offset:0.5,0.5,0.5 speed:0.5


ps_shape_circle_bottom:
    type: task
    definitions: location|particle|count
    script:
    - repeat <[count]>:
        - foreach <[location].center.below[0.4].points_around_y[radius=0.35;points=3]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:<[count]> offset:0 speed:0.5
        - foreach <[location].center.below[0.4].points_around_y[radius=0.15;points=5]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:<[count]> offset:0 speed:0.5
        - foreach <[location].center.below[0.4].points_around_y[radius=0.45;points=7]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:<[count]> offset:0 speed:0.5

    

ps_shape_circle_top:
    type: task
    definitions: location|particle|count
    script:
    - foreach <[location].center.above[0.4].points_around_y[radius=0.35;points=10]> as:loc:
        - playeffect at:<[loc]> effect:<[particle]> count:<[count]> offset:0 speed:0.5
        - wait 1t
        

ps_particle_inventory_events:
    type: world
    debug: false
    events:
        # Handle particle selection
        on player clicks item in ps_particle_inventory_*:
        - if <context.item.script.name.if_null[no name]> == particle_inventory_left_item:
            - inventory open d:<inventory[ps_particle_inventory_1]>
        - else if <context.item.script.name.if_null[no name]> == particle_inventory_right_item:
            - inventory open d:<inventory[ps_particle_inventory_2]>
        - else if !<context.item.has_flag[particle]>:
            - determine cancelled
        - else:
            - define particle <context.item.flag[particle]>
            - inventory flag slot:hand particle:<[particle]>
            - narrate "<&a>You have selected the <&c><[particle].to_sentence_case> <&a>particle."
            - inventory close

ps_particle_inventory_1:
    type: inventory
    title: Particle Menu
    inventory: chest
    gui: true
    size: 54
    procedural items:
        - define list <list>
        - foreach <server.particle_types> as:particle:
            - if <[loop_index]> < 54:
                - define item <item[stick]>
                - define item <[item].with[display_name=<&c><[particle].to_sentence_case>]>
                - define item <[item].with[lore=<list[<&8>|<&a><&o>Click to select this particle]>]>
                - define item <[item].with_flag[particle:<[particle]>]>
            - else:
                - define item <item[particle_inventory_right_item]>
            - define list <[list].include[<[item]>]>
        - determine <[list]>

ps_particle_inventory_2:
    type: inventory
    title: Particle Menu
    inventory: chest
    gui: true
    size: 54
    procedural items:
        - define list <list>
        - foreach <server.particle_types> as:particle:
            - if <[loop_index]> < 53:
                - foreach next
            - else if <[loop_index]> == 53:
                - define item <item[particle_inventory_left_item]>
            - else:
                - define item <item[stick]>
                - define item <[item].with[display_name=<&c><[particle].to_sentence_case>]>
                - define item <[item].with[lore=<list[<&8>|<&a><&o>Click to select this particle]>]>
                - define item <[item].with_flag[particle:<[particle]>]>
            - define list <[list].include[<[item]>]>
        - determine <[list]>

particle_inventory_left_item:
    type: item
    debug: false
    material: player_head
    display name: <&a>Previous Page
    mechanisms:
        skull_skin: 6d9cb85a-2b76-4e1f-bccc-941978fd4de0|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTE4NWM5N2RiYjgzNTNkZTY1MjY5OGQyNGI2NDMyN2I3OTNhM2YzMmE5OGJlNjdiNzE5ZmJlZGFiMzVlIn19fQ==

particle_inventory_right_item:
    type: item
    debug: false
    material: player_head
    display name: <&a>Next Page
    mechanisms:
        skull_skin: 3cd9b7a3-c8bc-4a05-8cb9-0b6d4673bca9|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzFjMGVkZWRkNzExNWZjMWIyM2Q1MWNlOTY2MzU4YjI3MTk1ZGFmMjZlYmI2ZTQ1YTY2YzM0YzY5YzM0MDkxIn19fQ