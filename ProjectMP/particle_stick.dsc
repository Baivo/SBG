# Particle Stick #
particle_stick:
    type: item
    material: stick
    mechanisms:
        custom_model_data: 17
    display name: <&e>Particle Stick
    lore:
    - <&8><&gt> <&7>Right click to place particles
    - <&8><&gt> <&7>Left click to remove particles
    - <&8><&gt> <&7>Throw (Q) to change particles
    flags:
        particle: SPELL_WITCH
        particle_frequency: 10
        particle_shape: circle

# particle Stick Events #
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
        - flag <[location]> particle.<[id]>.frequency:<player.item_in_hand.flag[particle_frequency]>
        - flag <[location]> particle.<[id]>.shape:<player.item_in_hand.flag[particle_shape]>
        - flag <[location]> particle.<[id]>.rotation:<player.item_in_hand.flag[particle_rotation]>
        - actionbar "<&7>Particles created at: <&color[#bfbfbf]>x <&color[#d65c5c]><[location].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[location].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[location].round_down.z>"
        on player left clicks block with:particle_stick:
        - determine cancelled passively
        - define location <context.relative>
        - if <[location].has_flag[particle]>:
            - flag server particle_stick_location:<-:<[location]>
            - flag <[location]> particle:!
            - actionbar "<&7>Removed particles from: <&color[#bfbfbf]>x <&color[#d65c5c]><[location].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[location].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[location].round_down.z>"
        - else:
            - actionbar "<&7>No particles to remove at: <&color[#bfbfbf]>x <&color[#d65c5c]><[location].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[location].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[location].round_down.z>"
        on player drops particle_stick:
        - determine cancelled passively
        - inventory open d:<inventory[ps_menu_inventory]>
        on delta time secondly priority:99:
        - foreach <server.flag[particle_stick_location].if_null[<list>]> as:location:
            - run ps_ticker def.location:<[location]>
# Particle Stick Event Scripts #

ps_ticker:
    type: task
    definitions: location
    script:
        - foreach <[location].flag[particle]> as:id:
            - ~run ps_shape_<[id].get[shape]> def.location:<[location]> def.particle:<[id].get[particle]> def.frequency:<[id].get[frequency]>

# Inventory Scripts #
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
                - define item <item[ps_inventory_right_item]>
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
                - define item <item[ps_inventory_left_item]>
            - else:
                - define item <item[stick]>
                - define item <[item].with[display_name=<&c><[particle].to_sentence_case>]>
                - define item <[item].with[lore=<list[<&8>|<&a><&o>Click to select this particle]>]>
                - define item <[item].with_flag[particle:<[particle]>]>
            - define list <[list].include[<[item]>]>
        - determine <[list]>

ps_menu_inventory:
    type: inventory
    inventory: hopper
    gui: true
    size: 5
    slots:
    - [ps_inventory_info_item] [ps_inventory_particle_item] [ps_inventory_shape_item] [ps_inventory_rotation_item] [ps_inventory_frequency_item]

ps_shape_inventory:
    type: inventory
    inventory: chest
    gui: true
    size: 9
    slots:
    - [] [] [] [] [] [] [] [] []

ps_frequency_inventory:
    type: inventory
    inventory: hopper
    gui: true
    size: 5
    slots:
    - [] [] [] [] []

ps_rotation_inventory:
    type: inventory
    inventory: dispenser
    gui: true
    size: 9
    slots:
    - [ps_inventory_top_arrow] [ps_inventory_spacer] [ps_inventory_spacer]
    - [ps_inventory_bottom_arrow] [ps_inventory_north_arrow] [ps_inventory_east_arrow]
    - [ps_inventory_spacer] [ps_inventory_west_arrow] [ps_inventory_south_arrow]

# Inventory Events #
ps_particle_inventory_events:
    type: world
    debug: false
    events:
        # Handle particle selection
        on player clicks item in ps_particle_inventory_*:
        - if <context.item.script.name.if_null[no name]> == ps_inventory_left_item:
            - inventory open d:<inventory[ps_particle_inventory_1]>
        - else if <context.item.script.name.if_null[no name]> == ps_inventory_right_item:
            - inventory open d:<inventory[ps_particle_inventory_2]>
        - else if !<context.item.has_flag[particle]>:
            - determine cancelled
        - else:
            - if <player.item_in_hand.has_flag[particle]>:
                - define particle <context.item.flag[particle]>
                - inventory flag slot:hand particle:<[particle]>
                - actionbar "<&a>Particle set to <&e><[particle].to_sentence_case>"
                - inventory close
            - else:
                - narrate "<&c>You must be holding a particle stick to select a particle."
        on player clicks item in ps_menu_inventory:
        - if <context.item.script.name.if_null[no name]> == ps_inventory_particle_item:
            - inventory open d:<inventory[ps_particle_inventory_1]>
        - else if <context.item.script.name.if_null[no name]> == ps_inventory_shape_item:
            - inventory open d:<inventory[ps_shape_inventory]>
        - else if <context.item.script.name.if_null[no name]> == ps_inventory_rotation_item:
            - inventory open d:<inventory[ps_rotation_inventory]>
        - else if <context.item.script.name.if_null[no name]> == ps_inventory_frequency_item:
            - inventory open d:<inventory[ps_frequency_inventory]>
        - else if <context.item.script.name.if_null[no name]> == ps_inventory_info_item:
            - narrate "Open a book or something to display info here."
        on player clicks item in ps_rotation_inventory:
        - if <context.item.has_flag[rotation]>:
            - if <player.item_in_hand.has_flag[particle_rotation]>:
                - inventory flag slot:hand particle_rotation:<context.item.flag[rotation]>
                - actionbar "<&a>Rotation set to: <&e><context.item.flag[rotation].to_sentence_case>"
                - inventory close
            - else:
                - narrate "<&c>You must be holding a particle stick to select a rotation."

# Inventory Items #
ps_inventory_left_item:
    type: item
    debug: false
    material: player_head
    display name: <&a>Previous Page
    mechanisms:
        skull_skin: 6d9cb85a-2b76-4e1f-bccc-941978fd4de0|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTE4NWM5N2RiYjgzNTNkZTY1MjY5OGQyNGI2NDMyN2I3OTNhM2YzMmE5OGJlNjdiNzE5ZmJlZGFiMzVlIn19fQ==

ps_inventory_right_item:
    type: item
    debug: false
    material: player_head
    display name: <&a>Next Page
    mechanisms:
        skull_skin: 3cd9b7a3-c8bc-4a05-8cb9-0b6d4673bca9|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzFjMGVkZWRkNzExNWZjMWIyM2Q1MWNlOTY2MzU4YjI3MTk1ZGFmMjZlYmI2ZTQ1YTY2YzM0YzY5YzM0MDkxIn19fQ


ps_inventory_north_arrow:
    type: item
    material: player_head
    display name: <&3>North
    mechanisms:
        skull_skin: 64a54e6d-b7c3-4ffe-b760-498fc306748b|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOGYyZWQ0ZWYzNThiZjkyNTJlYTczYTZiMGY0ZTg2OGIyN2ZlZWJjYWU2MDNlZTVlNWQwOTgyYjZkOWU2NjkwIn19fQ==
    flags:
        rotation: north

ps_inventory_east_arrow:
    type: item
    material: player_head
    display name: <&3>East
    mechanisms:
        skull_skin: 03cf7cdd-a24f-4bdc-9a69-ab63c39dba95|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZDJkMDMxM2I2NjgwMTQxMjg2Mzk2ZTcxYzM2MWU1OTYyYTM5YmFmNTk2ZDdlNTQ3NzE3NzVkNWZhM2QifX19
    flags:
        rotation: east

ps_inventory_south_arrow:
    type: item
    material: player_head
    display name: <&3>South
    mechanisms:
        skull_skin: fe6a649d-f209-4af6-845c-3b3a2cb97b43|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMjVhYjI3MWY3NzkxNzc0NWQyYjU0ODRiN2NhNDJlNTIzMTZlMTdkZTRmMDExYjA0YTRmOGE4NjVlYzU2ZGU3In19fQ==
    flags:
        rotation: south

ps_inventory_west_arrow:
    type: item
    material: player_head
    display name: <&3>West
    mechanisms:
        skull_skin: 378a4a5a-aaa1-41de-a6e7-2bd0844cc73e|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvODQxZGQxMjc1OTVhMjVjMjQzOWM1ZGIzMWNjYjQ5MTQ1MDdhZTE2NDkyMWFhZmVjMmI5NzlhYWQxY2ZlNyJ9fX0=
    flags:
        rotation: west

ps_inventory_top_arrow:
    type: item
    material: player_head
    display name: <&3>Top
    mechanisms:
        skull_skin: 2bb8d02d-c17f-44b0-b6fe-2b9307aa72ea|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNmNjYmY5ODgzZGQzNTlmZGYyMzg1YzkwYTQ1OWQ3Mzc3NjUzODJlYzQxMTdiMDQ4OTVhYzRkYzRiNjBmYyJ9fX0=
    flags:
        rotation: top

ps_inventory_bottom_arrow:
    type: item
    material: player_head
    display name: <&3>Bottom
    mechanisms:
        skull_skin: 90dae868-ec0a-4989-8705-97e32490ca5d|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNzI0MzE5MTFmNDE3OGI0ZDJiNDEzYWE3ZjVjNzhhZTQ0NDdmZTkyNDY5NDNjMzFkZjMxMTYzYzBlMDQzZTBkNiJ9fX0=
    flags:
        rotation: bottom

ps_inventory_spacer:
    type: item
    material: black_stained_glass_pane
    display name: <&8>


ps_inventory_particle_item:
    type: item
    material: redstone_dust
    display name: <&e>Change Particle
    lore:
    - <&8>
    - <&a>Click to change the particle type.
    - <&b>Current particle: <&e><player.item_in_hand.flag[particle].if_null[invalid item, don't switch from the stick while using this menu bozo]>

ps_inventory_shape_item:
    type: item
    material: golden_
    display name: <&e>Change Shape
    lore:
    - <&8>
    - <&a>Click to change particle animation / shape.
    - <&b>Current shape: <&e><player.item_in_hand.flag[particle_shape].if_null[invalid item, don't switch from the stick while using this menu bozo]>

ps_inventory_frequency_item:
    type: item
    material: apple
    display name: <&e>Change Frequency
    lore:
    - <&8>
    - <&a>Click to change the shape frequency.
    - <&b>Current frequency: <&e><player.item_in_hand.flag[particle_frequency].if_null[invalid item, don't switch from the stick while using this menu bozo]>
    - <&7>
    - <&7><&o>See the info book for help.

ps_inventory_rotation_item:
    type: item
    material: recovery_compass
    display name: <&e>Change Rotation
    lore:
    - <&8>
    - <&a><&o>Click to change the shape rotation.
    - <&b><&o>Current rotation: <&e><player.item_in_hand.flag[particle_rotation].if_null[invalid item, don't switch from the stick while using this menu bozo]>
    - <&7>
    - <&7><&o>See the info book for help.

ps_inventory_info_item:
    type: item
    material: writable_book
    display name: <&7>User Manual
    lore:
    - <&8>
    - <&a>Click to open the user manual.
    - <&7>
    - <&7><&o>Check out the demo sphere
    - <&7><&o>/warp particle_demo

## Particle Shapes ##
ps_shape_debug:
    type: task
    definitions: location|particle|frequency
    script:
    - playeffect at:<[location].center> effect:<[particle]> count:1 offset:0.5,0.5,0.5 speed:0.5
# Particle Shape: Circle #

ps_shape_circle_bottom:
    type: task
    definitions: location|particle|frequency
    script:
    - define location <[location].center.below[0.4]>
    - repeat <[frequency]>:
        - wait <element[20].div[<[frequency]>].round_down>t
        - foreach <[location].points_around_y[radius=0.45;points=9]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_y[radius=0.35;points=7]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_y[radius=0.25;points=5]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_y[radius=0.15;points=3]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5

ps_shape_circle_top:
    type: task
    definitions: location|particle|frequency
    script:
    - define location <[location].center.above[0.4]>
    - repeat <[frequency]>:
        - wait <element[20].div[<[frequency]>].round_down>t
        - foreach <[location].points_around_y[radius=0.45;points=9]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_y[radius=0.35;points=7]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_y[radius=0.25;points=5]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_y[radius=0.15;points=3]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5

ps_shape_circle_north:
    type: task
    definitions: location|particle|frequency
    script:
    - define location <[location].center.with_z[<[location].center.z.sub[0.4]>]>
    - repeat <[frequency]>:
        - wait <element[20].div[<[frequency]>].round_down>t
        - foreach <[location].points_around_x[radius=0.45;points=9]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_x[radius=0.45;points=7]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_x[radius=0.45;points=5]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_x[radius=0.45;points=3]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5

ps_shape_circle_east:
    type: task
    definitions: location|particle|frequency
    script:
    - define location <[location].center.with_x[<[location].center.z.add[0.4]>]>
    - repeat <[frequency]>:
        - wait <element[20].div[<[frequency]>].round_down>t
        - foreach <[location].points_around_z[radius=0.45;points=9]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_z[radius=0.45;points=7]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_z[radius=0.45;points=5]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_z[radius=0.45;points=3]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5

ps_shape_circle_south:
    type: task
    definitions: location|particle|frequency
    script:
    - define location <[location].center.with_z[<[location].center.z.add[0.4]>]>
    - repeat <[frequency]>:
        - wait <element[20].div[<[frequency]>].round_down>t
        - foreach <[location].points_around_x[radius=0.45;points=9]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_x[radius=0.45;points=7]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_x[radius=0.45;points=5]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_x[radius=0.45;points=3]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5

ps_shape_circle_west:
    type: task
    definitions: location|particle|frequency
    script:
    - define location <[location].center.with_x[<[location].center.z.sub[0.4]>]>
    - repeat <[frequency]>:
        - wait <element[20].div[<[frequency]>].round_down>t
        - foreach <[location].points_around_z[radius=0.45;points=9]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_z[radius=0.45;points=7]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_z[radius=0.45;points=5]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
        - foreach <[location].points_around_z[radius=0.45;points=3]> as:loc:
            - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
