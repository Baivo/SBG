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
        particle_frequency: 3
        particle_shape: circle
        particle_rotation: bottom

# particle Stick Events #
ps_item_events:
    type: world
    events:
        on player right clicks !air with:particle_stick:
        - ratelimit <player> 2t
        - determine cancelled passively
        - define location <context.relative>
        - if !<location[<[location]>].is_truthy>:
            - determine cancelled
        - define id <util.random_uuid>
        - flag server particle_stick_location:->:<[location]>
        - flag <[location]> particle.id:->:<[id]>
        - flag <[location]> particle.<[id]>.owner:<player.name>
        - flag <[location]> particle.<[id]>.particle:<player.item_in_hand.flag[particle]>
        - flag <[location]> particle.<[id]>.frequency:<player.item_in_hand.flag[particle_frequency]>
        - flag <[location]> particle.<[id]>.shape:<player.item_in_hand.flag[particle_shape]>
        - flag <[location]> particle.<[id]>.rotation:<player.item_in_hand.flag[particle_rotation]>
        - actionbar "<&7>Particles created at: <&color[#bfbfbf]>x <&color[#d65c5c]><[location].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[location].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[location].round_down.z>"
        on player left clicks !air with:particle_stick:
        - if <player.is_sneaking>:
            - determine cancelled passively
            - foreach <player.location.find_blocks_flagged[particle].within[16]> as:pl:
                - debugblock <[pl]> d:5t
        - else:
            - if <context.material.name> == air:
                - determine cancelled
            - else:
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
        - wait 2t
        - inventory open d:<inventory[ps_menu_inventory]>
        on delta time secondly priority:99:
        - foreach <server.flag[particle_stick_location].if_null[<list>]> as:location:
            - if !<[location].chunk.is_loaded>:
                - foreach next
            - if <[location].is_truthy>:
                - run ps_ticker def.location:<[location]>
        #alchemy shape animation ticker
        - ~run ps_animation_alchemy

# Particle Stick Event Scripts #
ps_animation_alchemy:
    type: task
    script:
    - define repeat <server.flag[alchtick_repeat].if_null[1]>
    - define delay <element[1].div[<[repeat]>].as[duration].in_ticks>t
    - repeat <[repeat]>:
        - define alchtick <server.flag[alchtick].if_null[0]>
        - if <[alchtick]> <= 358:
            - flag server alchtick:<[alchtick].add[1]>
        - else if <[alchtick]> == 359:
            - flag server alchtick:0
        - wait <[delay]>

ps_ticker:
    type: task
    definitions: location
    script:
    - if !<[location].has_flag[particle.id]>:
        - stop
    - foreach <[location].flag[particle.id]> as:particle:
        - define id <[location].flag[particle.<[particle]>]>
        - ~run ps_shape_<[id].get[shape]> def.location:<[location].center> def.particle:<[id].get[particle]> def.frequency:<[id].get[frequency]> def.rotation:<[id].get[rotation]>

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



ps_shape_inventory:
    type: inventory
    inventory: chest
    gui: true
    size: 9
    slots:
    - [ps_shapes_item_single] [ps_shapes_item_circle] [ps_shapes_item_ring] [ps_shapes_item_alchemy] [] [] [] [] []

ps_frequency_inventory:
    type: inventory
    inventory: hopper
    gui: true
    size: 5
    slots:
    - [ps_inventory_frequencyup_item] [ps_inventory_frequencyup5_item] [ps_inventory_frequencyinfo_item] [ps_inventory_frequencydown5_item] [ps_inventory_frequencydown_item]

ps_rotation_inventory:
    type: inventory
    inventory: dispenser
    gui: true
    size: 9
    slots:
    - [ps_inventory_top_arrow] [ps_inventory_center_arrow] [ps_inventory_spacer]
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
        on player clicks item in ps_shape_inventory:
        - if <context.item.has_flag[shape]>:
            - if <player.item_in_hand.has_flag[particle_shape]>:
                - inventory flag slot:hand particle_shape:<context.item.flag[shape]>
                - actionbar "<&a>Shape set to: <&e><context.item.flag[shape].to_sentence_case>"
                - inventory close
            - else:
                - narrate "<&c>You must be holding a particle stick to select a shape."
        on player clicks item in ps_frequency_inventory:
        - choose <context.item.script.name.if_null[no_name]>:
            - case ps_inventory_frequencyup_item:
                - define frequency <player.item_in_hand.flag[particle_frequency]>
                - if <[frequency]> <= 19:
                    - ~run ps_inventory_frequency_task def.frequency:<[frequency].add[1]>
                - else if <[frequency]> == 20:
                    - narrate "<&c>Frequency cannot be higher than 20."
                    - inventory close
            - case ps_inventory_frequencyup5_item:
                - define frequency <player.item_in_hand.flag[particle_frequency]>
                - if <[frequency]> <= 15:
                    - ~run ps_inventory_frequency_task def.frequency:<[frequency].add[5]>
                - else if <[frequency]> > 15:
                    - ~run ps_inventory_frequency_task def.frequency:20
                    - inventory close
                - else if <[frequency]> == 20:
                    - narrate "<&c>Frequency cannot be higher than 20."
                    - inventory close
            - case ps_inventory_frequencydown_item:
                - define frequency <player.item_in_hand.flag[particle_frequency]>
                - if <[frequency]> >= 2:
                    - ~run ps_inventory_frequency_task def.frequency:<[frequency].sub[1]>
                - else if <[frequency]> == 1:
                    - narrate "<&c>Frequency cannot be lower than 1."
                    - inventory close
            - case ps_inventory_frequencydown5_item:
                - define frequency <player.item_in_hand.flag[particle_frequency]>
                - if <[frequency]> >= 6:
                    - ~run ps_inventory_frequency_task def.frequency:<[frequency].sub[5]>
                - else if <[frequency]> < 6:
                    - ~run ps_inventory_frequency_task def.frequency:1
                    - inventory close
                - else if <[frequency]> == 1:
                    - narrate "<&c>Frequency cannot be lower than 1."
                    - inventory close
            - case ps_inventory_frequencyreset_item:
                - ~run ps_inventory_frequency_task def.frequency:1

ps_inventory_frequency_task:
    type: task
    debug: false
    definitions: frequency
    script:
    - inventory flag slot:hand particle_frequency:<[frequency]>
    - actionbar "<&a>Frequency set to: <&e><[frequency]>"
    - inventory open d:<inventory[ps_frequency_inventory]>

## Inventory Items ##

# Shape Items #
ps_shapes_item_circle:
    type: item
    material: gray_dye
    display name: <&e>Square
    flags:
        shape: square
    lore:
    - <&8>
    - <&a>Click to change shape to <&e>Square
    - <&8>
    - <&7>Creates a square shape,
    - <&7>covers 1 block face.

ps_shapes_item_square:
    type: item
    material: gray_dye
    display name: <&e>Circle
    flags:
        shape: circle
    lore:
    - <&8>
    - <&a>Click to change shape to <&e>Circle
    - <&8>
    - <&7>Creates an approximate circle shape,
    - <&7>covers 1 block face.

ps_shapes_item_single:
    type: item
    material: light_gray_dye
    display name: <&e>Single
    flags:
        shape: single
    lore:
    - <&8>
    - <&a>Click to change shape to <&e>Single
    - <&8>
    - <&7>Creates a single particle,
    - <&7>centered at the block face.

ps_shapes_item_ring:
    type: item
    material: gray_dye
    display name: <&e>Ring
    flags:
        shape: ring
    lore:
    - <&8>
    - <&a>Click to change shape to <&e>Ring
    - <&8>
    - <&7>Creates a ring of particles
    - <&7>around the edge of a block.

ps_shapes_item_alchemy:
    type: item
    material: light_gray_dye
    display name: <&e>Alchemy
    flags:
        shape: alchemy
    lore:
    - <&8>
    - <&a>Click to change shape to <&e>Alchemy
    - <&8>
    - <&7>Creates a spooky ring of particles
    - <&7>across many blocks!
    - <&7>No rotation support (yet).

# Spacers #
ps_inventory_spacer:
    type: item
    material: black_stained_glass_pane
    display name: <&8>

# Particle page arrows #
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

# Particle Rotation Direction Arrows #
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

ps_inventory_center_arrow:
    type: item
    material: player_head
    display name: <&3>Center
    mechanisms:
        skull_skin: 65690ca9-4a07-4f7c-b622-836fa9b46120|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYjhkNzNiYTI1NzVjMmFmM2U3M2UwNTdjYTBlMTUxZGU2NjMwZWY0Y2U0OTQ5ODg1ZWFjNTU1NWYzZWMyMmZhYyJ9fX0=
    flags:
        rotation: center

# Frequency Menu Items #
ps_inventory_frequencyinfo_item:
    type: item
    material: writable_book
    display name: <&e>Particle Frequency
    lore:
    - <&8>
    - <&a>Current Frequency: <&e><player.item_in_hand.flag[particle_frequency]>

ps_inventory_frequencyup_item:
    type: item
    material: player_head
    display name: <&3>Frequency +1
    mechanisms:
        skull_skin: 2bb8d02d-c17f-44b0-b6fe-2b9307aa72ea|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNmNjYmY5ODgzZGQzNTlmZGYyMzg1YzkwYTQ1OWQ3Mzc3NjUzODJlYzQxMTdiMDQ4OTVhYzRkYzRiNjBmYyJ9fX0=
    flags:
        frequency: 1

ps_inventory_frequencyup5_item:
    type: item
    material: player_head
    display name: <&3>Frequency +5
    mechanisms:
        skull_skin: daf047f5-cf80-4fdf-bbc8-d7b676c97fcf|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOWNkYjhmNDM2NTZjMDZjNGU4NjgzZTJlNjM0MWI0NDc5ZjE1N2Y0ODA4MmZlYTRhZmYwOWIzN2NhM2M2OTk1YiJ9fX0=
    flags:
        frequency: 5

ps_inventory_frequencydown_item:
    type: item
    material: player_head
    display name: <&3>Frequency -1
    mechanisms:
        skull_skin: 90dae868-ec0a-4989-8705-97e32490ca5d|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNzI0MzE5MTFmNDE3OGI0ZDJiNDEzYWE3ZjVjNzhhZTQ0NDdmZTkyNDY5NDNjMzFkZjMxMTYzYzBlMDQzZTBkNiJ9fX0=
    flags:
        frequency: -1

ps_inventory_frequencydown5_item:
    type: item
    material: player_head
    display name: <&3>Frequency -5
    mechanisms:
        skull_skin: 2b529a28-1db9-4450-a3eb-6c9897417bbb|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNjFlMWU3MzBjNzcyNzljOGUyZTE1ZDhiMjcxYTExN2U1ZTJjYTkzZDI1YzhiZTNhMDBjYzkyYTAwY2MwYmI4NSJ9fX0=
    flags:
        frequency: -5

ps_inventory_frequencyreset_item:
    type: item
    material: player_head
    display name: <&3>Reset Frequency
    flags:
        frequency: 0

# Particle Stick GUI Menu Items
ps_menu_description_handler:
    type: world
    events:
        on player opens ps_menu_inventory:
        #particle item
        - define pitem <item[ps_inventory_particle_item]>
        - define plore <[pitem].lore.include[<&b>Current particle: <&e><player.item_in_hand.flag[particle].to_sentence_case.if_null[no particle]>]>
        #shape item
        - define sitem <item[ps_inventory_shape_item]>
        - define slore <[sitem].lore.include[<&b>Current shape: <&e><player.item_in_hand.flag[particle_shape].to_sentence_case.if_null[no shape]>]>
        #rotation item
        - define ritem <item[ps_inventory_rotation_item]>
        - define rlore <[ritem].lore.include[<&b>Current rotation: <&e><player.item_in_hand.flag[particle_rotation].to_sentence_case.if_null[no rotation]>]>
        #frequency item
        - define fitem <item[ps_inventory_frequency_item]>
        - define flore <[fitem].lore.include[<&b>Current frequency: <&e><player.item_in_hand.flag[particle_frequency].if_null[no frequency]>]>
        - inventory adjust d:<context.inventory> slot:2 lore:<[plore]>
        - inventory adjust d:<context.inventory> slot:3 lore:<[slore]>
        - inventory adjust d:<context.inventory> slot:4 lore:<[rlore]>
        - inventory adjust d:<context.inventory> slot:5 lore:<[flore]>
        - inventory update

ps_menu_inventory:
    type: inventory
    inventory: hopper
    title: <&sp><&sp><&sp><&sp><&sp><&sp><&sp><&sp><&sp><&sp><&3><&l>Particle Stick
    gui: true
    size: 5
    slots:
    - [ps_inventory_info_item] [ps_inventory_particle_item] [ps_inventory_shape_item] [ps_inventory_rotation_item] [ps_inventory_frequency_item]

ps_inventory_particle_item:
    type: item
    material: redstone
    display name: <&e>Change Particle
    lore:
    - <&8>
    - <&a>Click to change the particle type.

ps_inventory_shape_item:
    type: item
    material: gray_dye
    display name: <&e>Change Shape
    lore:
    - <&8>
    - <&a>Click to change particle animation / shape.

ps_inventory_frequency_item:
    type: item
    material: clock
    display name: <&e>Change Frequency
    lore:
    - <&8>
    - <&a>Click to change the shape frequency.

ps_inventory_rotation_item:
    type: item
    material: recovery_compass
    display name: <&e>Change Rotation
    lore:
    - <&8>
    - <&a><&o>Click to change the shape rotation.

ps_inventory_info_item:
    type: item
    material: writable_book
    display name: <&7>User Manual
    lore:
    - <&8>
    - <&a>Click to open the user manual.

## Particle Shapes ##
# Particle Shape: Single #

ps_shape_single:
    type: task
    definitions: location|particle|frequency|rotation
    script:
    - define delay <element[1].div[<[frequency]>].as[duration].in_ticks>t
    
    - repeat <[frequency]>:
        - playeffect at:<[location]> effect:<[particle]>  offset:0.05
        - wait <[delay]>

# Location is the centre of the block the particle is being played at
#
# Particle is the particle type
#
# Frequency is the amount of times the script is run per second, 20 is the max
#
#   Some frequency examples:
#    1 = 1 particle per second at the start of each new second.
#    2 = 2 particles per second, 1 particle every 0.5 seconds.
#    5 = 5 particles per second, 1 particle every 0.2 seconds.
#    20 = 20 particles per second, 1 particle every in-game tick.
#
# Particles in the examples above describes each 'run' of the particle shape.
# i.e 5 = 5 instances of the circle shape per second, 1 instance every 0.2 seconds.
#
# Rotation is the direction the particle is facing, this is used to determine the starting location of the particle.
#   Valid options are:
#    center = The center of the block
#    top = The top of the block
#    bottom = The bottom of the block
#    north = The north side of the block
#    east = The east side of the block
#    south = The south side of the block
#    west = The west side of the block


# Particle Shape: Circle #
ps_shape_circle:
    type: task
    definitions: location|particle|frequency|rotation
    script:
        - define delay <element[1].div[<[frequency]>].as[duration].in_ticks>t
        # Set particle origin from rotation option
        - choose <[rotation]>:
            - case center:
                - define axis y
            - case top:
                - define location <[location].above[0.4]>
                - define axis y
            - case bottom:
                - define location <[location].below[0.4]>
                - define axis y
            - case north:
                - define location <[location].center.with_z[<[location].center.z.sub[0.4]>]>
                - define axis z
            - case east:
                - define location <[location].center.with_x[<[location].center.x.add[0.4]>]>
                - define axis x
            - case south:
                - define location <[location].center.with_z[<[location].center.z.add[0.4]>]>
                - define axis z
            - case west:
                - define location <[location].center.with_x[<[location].center.x.sub[0.4]>]>
                - define axis x
        # Determine x|y|z axis choice based on rotation and play particles accordingly
        - choose <[axis]>:
            - case x:
                - repeat <[frequency]>:
                    - foreach <[location].points_around_x[radius=0.45;points=9]> as:loc:
                        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                    - foreach <[location].points_around_x[radius=0.35;points=7]> as:loc:
                        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                    - foreach <[location].points_around_x[radius=0.25;points=5]> as:loc:
                        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                    - foreach <[location].points_around_x[radius=0.15;points=3]> as:loc:
                        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                    - wait <[delay]>
            - case y:
                - repeat <[frequency]>:
                    - foreach <[location].points_around_y[radius=0.45;points=9]> as:loc:
                        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                    - foreach <[location].points_around_y[radius=0.35;points=7]> as:loc:
                        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                    - foreach <[location].points_around_y[radius=0.25;points=5]> as:loc:
                        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                    - foreach <[location].points_around_y[radius=0.15;points=3]> as:loc:
                        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                    - wait <[delay]>
            - case z:
                - repeat <[frequency]>:
                    - foreach <[location].points_around_z[radius=0.45;points=9]> as:loc:
                        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                    - foreach <[location].points_around_z[radius=0.35;points=7]> as:loc:
                        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                    - foreach <[location].points_around_z[radius=0.25;points=5]> as:loc:
                        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                    - foreach <[location].points_around_z[radius=0.15;points=3]> as:loc:
                        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                    - wait <[delay]>

# Particle Shape: Ring #
ps_shape_ring:
    type: task
    definitions: location|particle|frequency|rotation
    script:
    - define delay <element[1].div[<[frequency]>].as[duration].in_ticks>t
    # Set particle origin from rotation option
    - choose <[rotation]>:
        - case center:
            - define axis y
        - case top:
            - define location <[location].above[0.4]>
            - define axis y
        - case bottom:
            - define location <[location].below[0.4]>
            - define axis y
        - case north:
            - define location <[location].center.with_z[<[location].center.z.sub[0.4]>]>
            - define axis z
        - case east:
            - define location <[location].center.with_x[<[location].center.x.add[0.4]>]>
            - define axis x
        - case south:
            - define location <[location].center.with_z[<[location].center.z.add[0.4]>]>
            - define axis z
        - case west:
            - define location <[location].center.with_x[<[location].center.x.sub[0.4]>]>
            - define axis x
        # Determine x|y|z axis choice based on rotation and play particles accordingly
    - choose <[axis]>:
        - case x:
            - repeat <[frequency]>:
                - foreach <[location].points_around_x[radius=0.45;points=9]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                - wait <[delay]>
        - case y:
            - repeat <[frequency]>:
                - foreach <[location].points_around_y[radius=0.45;points=9]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                - wait <[delay]>
        - case z:
                - foreach <[location].points_around_z[radius=0.45;points=9]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> offset:0.0
                - wait <[delay]>

ps_shape_import:
    type: task
    definitions: location|particle|frequency|rotation
    script:
    - define shape <list[]>
    - define delay <element[1].div[<[frequency]>].as[duration].in_ticks>t
    - repeat <[frequency]>:
        - foreach <[shape]> as:vec:
            - playeffect at:<[location].relative[<[vec]>]> effect:<[particle]> offset:0.0
        - wait <[delay]>


ps_shape_alchemy:
    type: task
    definitions: location|particle|frequency|rotation
    script:
    - define delay <element[1].div[<[frequency]>].as[duration].in_ticks>t
    - define face <list[6,0,-3.375|6,0,-3.25|6,0,-3.125|6,0,-3|6,0,-2.875|6,0,0|6,0,2.625|6,0,2.75|6,0,2.875|6,0,3|6,0,3.125|5.875,0,-3.625|5.875,0,-3.5|5.875,0,-3.375|5.875,0,-2.875|5.875,0,-2.75|5.875,0,-2.625|5.875,0,-1.125|5.875,0,-1|5.875,0,-0.875|5.875,0,-0.75|5.875,0,-0.625|5.875,0,-0.5|5.875,0,-0.375|5.875,0,-0.25|5.875,0,-0.125|5.875,0,0|5.875,0,0.125|5.875,0,0.25|5.875,0,0.375|5.875,0,0.5|5.875,0,0.625|5.875,0,0.75|5.875,0,0.875|5.875,0,1|5.875,0,1.125|5.875,0,2.375|5.875,0,2.5|5.875,0,2.625|5.875,0,3.125|5.875,0,3.25|5.875,0,3.375|5.75,0,-3.75|5.75,0,-3.625|5.75,0,-2.625|5.75,0,-2.5|5.75,0,-1.625|5.75,0,-1.5|5.75,0,-1.375|5.75,0,-1.25|5.75,0,-1.125|5.75,0,1.125|5.75,0,1.25|5.75,0,1.375|5.75,0,1.5|5.75,0,1.625|5.75,0,2.25|5.75,0,2.375|5.75,0,3.375|5.75,0,3.5|5.625,0,-3.75|5.625,0,-2.5|5.625,0,-2|5.625,0,-1.875|5.625,0,-1.75|5.625,0,1.75|5.625,0,1.875|5.625,0,2|5.625,0,2.25|5.625,0,3.5|5.5,0,-3.875|5.5,0,-3.75|5.5,0,-2.5|5.5,0,-2.375|5.5,0,-2.25|5.5,0,-2.125|5.5,0,2.125|5.5,0,2.25|5.5,0,3.5|5.5,0,3.625|5.375,0,-3.875|5.375,0,-2.375|5.375,0,2.125|5.375,0,3.625|5.25,0,-3.875|5.25,0,-2.375|5.25,0,-2.25|5.25,0,-2.125|5.25,0,-2|5.25,0,-1.875|5.25,0,-1.75|5.25,0,-1.625|5.25,0,-1.5|5.25,0,-1.375|5.25,0,-1.25|5.25,0,-1.125|5.25,0,-1|5.25,0,-0.875|5.25,0,-0.75|5.25,0,-0.625|5.25,0,-0.5|5.25,0,-0.375|5.25,0,-0.25|5.25,0,-0.125|5.25,0,0|5.25,0,0.125|5.25,0,0.25|5.25,0,0.375|5.25,0,0.5|5.25,0,0.625|5.25,0,0.75|5.25,0,0.875|5.25,0,1|5.25,0,1.125|5.25,0,1.25|5.25,0,1.375|5.25,0,1.5|5.25,0,1.625|5.25,0,1.75|5.25,0,1.875|5.25,0,2|5.25,0,2.125|5.25,0,3.625|5.125,0,-3.875|5.125,0,-2.375|5.125,0,2.125|5.125,0,3.625|5,0,-3.875|5,0,-3.75|5,0,-2.5|5,0,-2.375|5,0,2.125|5,0,2.25|5,0,3.5|5,0,3.625|4.875,0,-3.75|4.875,0,-2.5|4.875,0,2.25|4.875,0,3.5|4.75,0,-3.75|4.75,0,-3.625|4.75,0,-2.625|4.75,0,-2.5|4.75,0,2.25|4.75,0,2.375|4.75,0,3.375|4.75,0,3.5|4.625,0,-3.75|4.625,0,-3.625|4.625,0,-3.5|4.625,0,-3.375|4.625,0,-2.875|4.625,0,-2.75|4.625,0,-2.625|4.625,0,2.375|4.625,0,2.5|4.625,0,2.625|4.625,0,3.125|4.625,0,3.25|4.625,0,3.375|4.625,0,3.625|4.625,0,3.75|4.5,0,-3.875|4.5,0,-3.75|4.5,0,-3.5|4.5,0,-3.375|4.5,0,-3.25|4.5,0,-3.125|4.5,0,-3|4.5,0,-2.875|4.5,0,-2.625|4.5,0,2.5|4.5,0,2.625|4.5,0,2.75|4.5,0,2.875|4.5,0,3|4.5,0,3.125|4.5,0,3.375|4.5,0,3.75|4.5,0,3.875|4.375,0,-4|4.375,0,-3.625|4.375,0,-2.625|4.375,0,2.375|4.375,0,3.375|4.375,0,4|4.25,0,-4.125|4.25,0,-3.625|4.25,0,-2.5|4.25,0,2.375|4.25,0,3.5|4.25,0,4.125|4.125,0,-4.25|4.125,0,-4.125|4.125,0,-3.75|4.125,0,-2.5|4.125,0,0|4.125,0,2.25|4.125,0,3.5|4.125,0,4.125|4.125,0,4.25|4,0,-4.375|4,0,-3.75|4,0,-2.375|4,0,-0.875|4,0,-0.75|4,0,-0.625|4,0,-0.5|4,0,-0.375|4,0,-0.25|4,0,-0.125|4,0,0|4,0,0.125|4,0,0.25|4,0,0.375|4,0,0.5|4,0,0.625|4,0,0.75|4,0,0.875|4,0,2.25|4,0,3.625|4,0,4.375|3.875,0,-4.5|3.875,0,-3.875|3.875,0,-2.25|3.875,0,-1.375|3.875,0,-1.25|3.875,0,-1.125|3.875,0,-1|3.875,0,1|3.875,0,1.125|3.875,0,1.25|3.875,0,1.375|3.875,0,2.125|3.875,0,3.75|3.875,0,4.5|3.75,0,-4.625|3.75,0,-4.5|3.75,0,-4|3.75,0,-2.25|3.75,0,-1.625|3.75,0,-1.5|3.75,0,-1.375|3.75,0,1.375|3.75,0,1.5|3.75,0,1.625|3.75,0,2|3.75,0,3.75|3.75,0,4.5|3.75,0,4.625|3.625,0,-4.625|3.625,0,-4|3.625,0,-2.125|3.625,0,-1.875|3.625,0,-1.75|3.625,0,-1.625|3.625,0,1.625|3.625,0,1.75|3.625,0,1.875|3.625,0,2|3.625,0,3.875|3.625,0,4.625|3.5,0,-4.75|3.5,0,-4.125|3.5,0,-2.125|3.5,0,-2|3.5,0,-1.875|3.5,0,-1.75|3.5,0,-1.625|3.5,0,-1.5|3.5,0,-1.375|3.5,0,-1.25|3.5,0,-1.125|3.5,0,-1|3.5,0,-0.875|3.5,0,-0.75|3.5,0,-0.625|3.5,0,-0.5|3.5,0,-0.375|3.5,0,-0.25|3.5,0,-0.125|3.5,0,0|3.5,0,0.125|3.5,0,0.25|3.5,0,0.375|3.5,0,0.5|3.5,0,0.625|3.5,0,0.75|3.5,0,0.875|3.5,0,1|3.5,0,1.125|3.5,0,1.25|3.5,0,1.375|3.5,0,1.5|3.5,0,1.625|3.5,0,1.75|3.5,0,1.875|3.5,0,2|3.5,0,4|3.5,0,4.75|3.375,0,-4.875|3.375,0,-4.125|3.375,0,-2.25|3.375,0,-2.125|3.375,0,-2|3.375,0,1.875|3.375,0,2|3.375,0,2.125|3.375,0,2.25|3.375,0,4|3.375,0,4.875|3.25,0,-5|3.25,0,-4.875|3.25,0,-4.25|3.25,0,-2.375|3.25,0,-2.25|3.25,0,-1.875|3.25,0,1.75|3.25,0,2|3.25,0,2.375|3.25,0,4.125|3.25,0,4.875|3.25,0,5|3.125,0,-5|3.125,0,-4.25|3.125,0,-2.625|3.125,0,-2.5|3.125,0,-2.375|3.125,0,-1.875|3.125,0,1.75|3.125,0,2.125|3.125,0,2.5|3.125,0,2.625|3.125,0,4.125|3.125,0,5|3,0,-5.125|3,0,-4.375|3,0,-2.75|3,0,-2.625|3,0,-2.375|3,0,-1.75|3,0,1.625|3,0,2.25|3,0,2.625|3,0,2.75|3,0,4.25|3,0,5.125|2.875,0,-5.125|2.875,0,-4.375|2.875,0,-2.875|2.875,0,-2.75|2.875,0,-2.5|2.875,0,-1.75|2.875,0,1.625|2.875,0,2.25|2.875,0,2.75|2.875,0,2.875|2.875,0,4.375|2.875,0,5.125|2.75,0,-5.25|2.75,0,-4.5|2.75,0,-3|2.75,0,-2.875|2.75,0,-2.5|2.75,0,-1.625|2.75,0,1.5|2.75,0,2.375|2.75,0,2.875|2.75,0,3|2.75,0,4.375|2.75,0,5.25|2.625,0,-5.375|2.625,0,-5.25|2.625,0,-4.625|2.625,0,-3.125|2.625,0,-3|2.625,0,-2.625|2.625,0,-1.5|2.625,0,1.375|2.625,0,2.375|2.625,0,3|2.625,0,3.125|2.625,0,4.5|2.625,0,5.25|2.625,0,5.375|2.5,0,-5.375|2.5,0,-4.625|2.5,0,-3.125|2.5,0,-2.625|2.5,0,-1.5|2.5,0,1.375|2.5,0,2.5|2.5,0,3.125|2.5,0,4.5|2.5,0,5.375|2.375,0,-5.375|2.375,0,-4.75|2.375,0,-3.25|2.375,0,-2.75|2.375,0,-1.375|2.375,0,1.25|2.375,0,2.625|2.375,0,3.25|2.375,0,4.625|2.375,0,5.375|2.25,0,-5.5|2.25,0,-4.75|2.25,0,-3.375|2.25,0,-2.75|2.25,0,-1.375|2.25,0,1.25|2.25,0,2.625|2.25,0,3.375|2.25,0,4.75|2.25,0,5.5|2.125,0,-5.5|2.125,0,-4.875|2.125,0,-3.375|2.125,0,-2.875|2.125,0,-1.25|2.125,0,1.125|2.125,0,2.75|2.125,0,3.375|2.125,0,4.75|2.125,0,5.5|2,0,-5.625|2,0,-4.875|2,0,-3.5|2,0,-2.875|2,0,-1.25|2,0,1.125|2,0,2.875|2,0,3.5|2,0,4.875|2,0,5.625|1.875,0,-5.625|1.875,0,-5|1.875,0,-3.625|1.875,0,-3.5|1.875,0,-3|1.875,0,-1.125|1.875,0,1|1.875,0,2.875|1.875,0,3.5|1.875,0,3.625|1.875,0,4.875|1.875,0,5.625|1.75,0,-5.625|1.75,0,-5|1.75,0,-3.625|1.75,0,-3.125|1.75,0,-1|1.75,0,1|1.75,0,3|1.75,0,3.625|1.75,0,5|1.75,0,5.625|1.625,0,-5.75|1.625,0,-5.125|1.625,0,-3.75|1.625,0,-3.625|1.625,0,-3.125|1.625,0,-1|1.625,0,0.875|1.625,0,3|1.625,0,3.625|1.625,0,3.75|1.625,0,5.125|1.625,0,5.75|1.5,0,-5.75|1.5,0,-5.125|1.5,0,-3.75|1.5,0,-3.25|1.5,0,-0.875|1.5,0,0.875|1.5,0,3.125|1.5,0,3.75|1.5,0,5.125|1.5,0,5.75|1.375,0,-5.75|1.375,0,-5.25|1.375,0,-3.875|1.375,0,-3.75|1.375,0,-3.25|1.375,0,-0.875|1.375,0,0.75|1.375,0,3.25|1.375,0,3.75|1.375,0,3.875|1.375,0,5.25|1.375,0,5.75|1.25,0,-5.75|1.25,0,-5.375|1.25,0,-3.875|1.25,0,-3.375|1.25,0,-0.75|1.25,0,0.625|1.25,0,3.25|1.25,0,3.875|1.25,0,5.375|1.25,0,5.75|1.125,0,-5.875|1.125,0,-5.75|1.125,0,-5.375|1.125,0,-3.875|1.125,0,-3.375|1.125,0,-0.625|1.125,0,0.625|1.125,0,3.375|1.125,0,3.875|1.125,0,5.375|1.125,0,5.75|1.125,0,5.875|1,0,-5.875|1,0,-5.5|1,0,-3.875|1,0,-3.5|1,0,-0.625|1,0,0.5|1,0,3.5|1,0,3.875|1,0,5.5|1,0,5.875|0.875,0,-5.875|0.875,0,-5.5|0.875,0,-4|0.875,0,-3.5|0.875,0,-0.5|0.875,0,0.5|0.875,0,3.5|0.875,0,4|0.875,0,5.5|0.875,0,5.875|0.75,0,-6.25|0.75,0,-6.125|0.75,0,-6|0.75,0,-5.875|0.75,0,-5.75|0.75,0,-5.625|0.75,0,-4|0.75,0,-3.625|0.75,0,-0.5|0.75,0,0.375|0.75,0,3.625|0.75,0,4|0.75,0,5.625|0.75,0,5.75|0.75,0,5.875|0.75,0,6|0.75,0,6.125|0.75,0,6.25|0.625,0,-6.5|0.625,0,-6.375|0.625,0,-6.25|0.625,0,-5.75|0.625,0,-5.625|0.625,0,-5.5|0.625,0,-4|0.625,0,-3.625|0.625,0,-0.375|0.625,0,0.375|0.625,0,3.625|0.625,0,4|0.625,0,5.5|0.625,0,5.625|0.625,0,5.75|0.625,0,6.25|0.625,0,6.375|0.625,0,6.5|0.5,0,-6.625|0.5,0,-6.5|0.5,0,-5.5|0.5,0,-5.375|0.5,0,-4|0.5,0,-3.75|0.5,0,-0.25|0.5,0,0.25|0.5,0,3.75|0.5,0,4|0.5,0,5.375|0.5,0,5.5|0.5,0,6.5|0.5,0,6.625|0.375,0,-6.625|0.375,0,-5.375|0.375,0,-4|0.375,0,-3.75|0.375,0,-0.25|0.375,0,0.25|0.375,0,3.875|0.375,0,4|0.375,0,5.375|0.375,0,6.625|0.25,0,-6.75|0.25,0,-6.625|0.25,0,-5.375|0.25,0,-5.25|0.25,0,-4|0.25,0,-3.875|0.25,0,-0.125|0.25,0,0.125|0.25,0,3.875|0.25,0,4|0.25,0,5.25|0.25,0,5.375|0.25,0,6.625|0.25,0,6.75|0.125,0,-6.75|0.125,0,-5.25|0.125,0,-4|0.125,0,-3.875|0.125,0,-0.125|0.125,0,0.125|0.125,0,4|0.125,0,5.25|0.125,0,6.75|0,0,-6.75|0,0,-5.25|0,0,-5.125|0,0,-5|0,0,-4.875|0,0,-4.75|0,0,-4.625|0,0,-4.5|0,0,-4.375|0,0,-4.25|0,0,-4.125|0,0,-4|0,0,-3.875|0,0,-3.75|0,0,-3.625|0,0,-3.5|0,0,-3.375|0,0,-3.25|0,0,-3.125|0,0,-3|0,0,-2.875|0,0,-2.75|0,0,-2.625|0,0,-2.5|0,0,-2.375|0,0,-2.25|0,0,-2.125|0,0,-2|0,0,-1.875|0,0,-1.75|0,0,-1.625|0,0,-1.5|0,0,-1.375|0,0,-1.25|0,0,-1.125|0,0,-1|0,0,-0.875|0,0,-0.75|0,0,-0.625|0,0,-0.5|0,0,-0.375|0,0,-0.25|0,0,-0.125|0,0,0|0,0,0.125|0,0,0.25|0,0,0.375|0,0,0.5|0,0,0.625|0,0,0.75|0,0,0.875|0,0,1|0,0,1.125|0,0,1.25|0,0,1.375|0,0,1.5|0,0,1.625|0,0,1.75|0,0,1.875|0,0,2|0,0,2.125|0,0,2.25|0,0,2.375|0,0,2.5|0,0,2.625|0,0,2.75|0,0,2.875|0,0,3|0,0,3.125|0,0,3.25|0,0,3.375|0,0,3.5|0,0,3.625|0,0,3.75|0,0,3.875|0,0,4|0,0,4.125|0,0,4.25|0,0,4.375|0,0,4.5|0,0,4.625|0,0,4.75|0,0,4.875|0,0,5|0,0,5.125|0,0,5.25|0,0,6.75|-0.125,0,-6.75|-0.125,0,-5.25|-0.125,0,-4|-0.125,0,-3.875|-0.125,0,-0.125|-0.125,0,0.125|-0.125,0,3.875|-0.125,0,4|-0.125,0,5.25|-0.125,0,6.75|-0.25,0,-6.75|-0.25,0,-6.625|-0.25,0,-5.375|-0.25,0,-5.25|-0.25,0,-4|-0.25,0,-3.875|-0.25,0,-0.125|-0.25,0,0.125|-0.25,0,3.75|-0.25,0,4|-0.25,0,5.25|-0.25,0,5.375|-0.25,0,6.625|-0.25,0,6.75|-0.375,0,-6.625|-0.375,0,-5.375|-0.375,0,-4|-0.375,0,-3.75|-0.375,0,-0.25|-0.375,0,0.25|-0.375,0,3.75|-0.375,0,4|-0.375,0,5.375|-0.375,0,6.625|-0.5,0,-6.625|-0.5,0,-6.5|-0.5,0,-5.5|-0.5,0,-5.375|-0.5,0,-4|-0.5,0,-3.75|-0.5,0,-0.25|-0.5,0,0.25|-0.5,0,3.625|-0.5,0,4|-0.5,0,5.375|-0.5,0,5.5|-0.5,0,6.5|-0.5,0,6.625|-0.625,0,-6.5|-0.625,0,-6.375|-0.625,0,-6.25|-0.625,0,-5.75|-0.625,0,-5.625|-0.625,0,-5.5|-0.625,0,-4|-0.625,0,-3.625|-0.625,0,-0.375|-0.625,0,0.375|-0.625,0,3.625|-0.625,0,4|-0.625,0,5.5|-0.625,0,5.625|-0.625,0,5.75|-0.625,0,6.25|-0.625,0,6.375|-0.625,0,6.5|-0.75,0,-6.25|-0.75,0,-6.125|-0.75,0,-6|-0.75,0,-5.875|-0.75,0,-5.75|-0.75,0,-5.5|-0.75,0,-4|-0.75,0,-3.5|-0.75,0,-0.5|-0.75,0,0.5|-0.75,0,3.5|-0.75,0,4|-0.75,0,5.5|-0.75,0,5.75|-0.75,0,5.875|-0.75,0,6|-0.75,0,6.125|-0.75,0,6.25|-0.875,0,-5.875|-0.875,0,-5.5|-0.875,0,-4|-0.875,0,-3.5|-0.875,0,-0.5|-0.875,0,0.5|-0.875,0,3.375|-0.875,0,4|-0.875,0,5.375|-0.875,0,5.5|-0.875,0,5.875|-1,0,-5.875|-1,0,-5.375|-1,0,-3.875|-1,0,-3.375|-1,0,-0.625|-1,0,0.625|-1,0,3.375|-1,0,3.875|-1,0,5.375|-1,0,5.875|-1.125,0,-5.875|-1.125,0,-5.75|-1.125,0,-5.375|-1.125,0,-3.875|-1.125,0,-3.375|-1.125,0,-0.625|-1.125,0,0.625|-1.125,0,3.25|-1.125,0,3.875|-1.125,0,5.25|-1.125,0,5.375|-1.125,0,5.75|-1.125,0,5.875|-1.25,0,-5.75|-1.25,0,-5.25|-1.25,0,-3.875|-1.25,0,-3.25|-1.25,0,-0.75|-1.25,0,0.75|-1.25,0,3.25|-1.25,0,3.875|-1.25,0,5.25|-1.25,0,5.75|-1.375,0,-5.75|-1.375,0,-5.25|-1.375,0,-3.875|-1.375,0,-3.75|-1.375,0,-3.125|-1.375,0,-0.75|-1.375,0,0.75|-1.375,0,3.125|-1.375,0,3.75|-1.375,0,3.875|-1.375,0,5.125|-1.375,0,5.25|-1.375,0,5.75|-1.5,0,-5.75|-1.5,0,-5.125|-1.5,0,-3.75|-1.5,0,-3.125|-1.5,0,-0.875|-1.5,0,0.875|-1.5,0,3.125|-1.5,0,3.75|-1.5,0,5.125|-1.5,0,5.75|-1.625,0,-5.75|-1.625,0,-5|-1.625,0,-3.75|-1.625,0,-3.625|-1.625,0,-3|-1.625,0,-1|-1.625,0,1|-1.625,0,3|-1.625,0,3.625|-1.625,0,3.75|-1.625,0,5|-1.625,0,5.75|-1.75,0,-5.625|-1.75,0,-5|-1.75,0,-3.625|-1.75,0,-3|-1.75,0,-1|-1.75,0,1|-1.75,0,2.875|-1.75,0,3.625|-1.75,0,4.875|-1.75,0,5|-1.75,0,5.625|-1.875,0,-5.625|-1.875,0,-4.875|-1.875,0,-3.625|-1.875,0,-3.5|-1.875,0,-2.875|-1.875,0,-1.125|-1.875,0,1.125|-1.875,0,2.875|-1.875,0,3.5|-1.875,0,3.625|-1.875,0,4.875|-1.875,0,5.625|-2,0,-5.625|-2,0,-4.875|-2,0,-3.5|-2,0,-2.875|-2,0,-1.125|-2,0,1.125|-2,0,2.75|-2,0,3.5|-2,0,4.75|-2,0,4.875|-2,0,5.625|-2.125,0,-5.5|-2.125,0,-4.75|-2.125,0,-3.375|-2.125,0,-2.75|-2.125,0,-1.25|-2.125,0,1.25|-2.125,0,2.75|-2.125,0,3.375|-2.125,0,4.75|-2.125,0,5.5|-2.25,0,-5.5|-2.25,0,-4.625|-2.25,0,-3.375|-2.25,0,-2.625|-2.25,0,-1.375|-2.25,0,1.375|-2.25,0,2.625|-2.25,0,3.375|-2.25,0,4.625|-2.25,0,5.5|-2.375,0,-5.375|-2.375,0,-4.625|-2.375,0,-3.25|-2.375,0,-2.625|-2.375,0,-1.375|-2.375,0,1.375|-2.375,0,2.625|-2.375,0,3.25|-2.375,0,4.625|-2.375,0,5.375|-2.5,0,-5.375|-2.5,0,-4.5|-2.5,0,-3.125|-2.5,0,-2.5|-2.5,0,-1.5|-2.5,0,1.5|-2.5,0,2.5|-2.5,0,3.125|-2.5,0,4.5|-2.5,0,5.375|-2.625,0,-5.375|-2.625,0,-5.25|-2.625,0,-4.5|-2.625,0,-3.125|-2.625,0,-3|-2.625,0,-2.5|-2.625,0,-1.5|-2.625,0,1.5|-2.625,0,2.375|-2.625,0,3|-2.625,0,3.125|-2.625,0,4.375|-2.625,0,4.5|-2.625,0,5.25|-2.625,0,5.375|-2.75,0,-5.25|-2.75,0,-4.375|-2.75,0,-3|-2.75,0,-2.875|-2.75,0,-2.375|-2.75,0,-1.625|-2.75,0,1.625|-2.75,0,2.375|-2.75,0,2.875|-2.75,0,3|-2.75,0,4.375|-2.75,0,5.25|-2.875,0,-5.125|-2.875,0,-4.375|-2.875,0,-2.875|-2.875,0,-2.75|-2.875,0,-2.25|-2.875,0,-1.625|-2.875,0,1.625|-2.875,0,2.25|-2.875,0,2.75|-2.875,0,2.875|-2.875,0,4.25|-2.875,0,4.375|-2.875,0,5.125|-3,0,-5.125|-3,0,-4.25|-3,0,-2.75|-3,0,-2.625|-3,0,-2.25|-3,0,-1.75|-3,0,1.75|-3,0,2.25|-3,0,2.625|-3,0,2.75|-3,0,4.25|-3,0,5.125|-3.125,0,-5|-3.125,0,-4.125|-3.125,0,-2.625|-3.125,0,-2.5|-3.125,0,-2.125|-3.125,0,-1.875|-3.125,0,1.875|-3.125,0,2.125|-3.125,0,2.5|-3.125,0,2.625|-3.125,0,4.125|-3.125,0,5|-3.25,0,-5|-3.25,0,-4.875|-3.25,0,-4.125|-3.25,0,-2.375|-3.25,0,-2.125|-3.25,0,-1.875|-3.25,0,1.875|-3.25,0,2.125|-3.25,0,2.375|-3.25,0,4.125|-3.25,0,4.875|-3.25,0,5|-3.375,0,-4.875|-3.375,0,-4|-3.375,0,-2.25|-3.375,0,-2.125|-3.375,0,-2|-3.375,0,-1.875|-3.375,0,-1.75|-3.375,0,-1.625|-3.375,0,-1.5|-3.375,0,-1.375|-3.375,0,-1.25|-3.375,0,-1.125|-3.375,0,-1|-3.375,0,-0.875|-3.375,0,-0.75|-3.375,0,-0.625|-3.375,0,-0.5|-3.375,0,-0.375|-3.375,0,-0.25|-3.375,0,-0.125|-3.375,0,0|-3.375,0,0.125|-3.375,0,0.25|-3.375,0,0.375|-3.375,0,0.5|-3.375,0,0.625|-3.375,0,0.75|-3.375,0,0.875|-3.375,0,1|-3.375,0,1.125|-3.375,0,1.25|-3.375,0,1.375|-3.375,0,1.5|-3.375,0,1.625|-3.375,0,1.75|-3.375,0,1.875|-3.375,0,2|-3.375,0,2.125|-3.375,0,2.25|-3.375,0,4|-3.375,0,4.875|-3.5,0,-4.75|-3.5,0,-4|-3.5,0,-2|-3.5,0,-1.875|-3.5,0,1.875|-3.5,0,2|-3.5,0,3.875|-3.5,0,4|-3.5,0,4.75|-3.625,0,-4.625|-3.625,0,-3.875|-3.625,0,-2.125|-3.625,0,-1.875|-3.625,0,-1.75|-3.625,0,-1.625|-3.625,0,1.625|-3.625,0,1.75|-3.625,0,1.875|-3.625,0,2.125|-3.625,0,3.875|-3.625,0,4.625|-3.75,0,-4.625|-3.75,0,-4.5|-3.75,0,-3.75|-3.75,0,-2.25|-3.75,0,-1.625|-3.75,0,-1.5|-3.75,0,-1.375|-3.75,0,1.375|-3.75,0,1.5|-3.75,0,1.625|-3.75,0,2.25|-3.75,0,3.75|-3.75,0,4.5|-3.75,0,4.625|-3.875,0,-4.5|-3.875,0,-3.75|-3.875,0,-2.25|-3.875,0,-1.375|-3.875,0,-1.25|-3.875,0,-1.125|-3.875,0,-1|-3.875,0,1|-3.875,0,1.125|-3.875,0,1.25|-3.875,0,1.375|-3.875,0,2.25|-3.875,0,3.75|-3.875,0,4.5|-4,0,-4.375|-4,0,-3.625|-4,0,-2.375|-4,0,-0.875|-4,0,-0.75|-4,0,-0.625|-4,0,-0.5|-4,0,-0.375|-4,0,-0.25|-4,0,-0.125|-4,0,0|-4,0,0.125|-4,0,0.25|-4,0,0.375|-4,0,0.5|-4,0,0.625|-4,0,0.75|-4,0,0.875|-4,0,2.375|-4,0,3.625|-4,0,4.375|-4.125,0,-4.25|-4.125,0,-4.125|-4.125,0,-3.625|-4.125,0,-2.375|-4.125,0,0|-4.125,0,2.375|-4.125,0,3.625|-4.125,0,4.125|-4.125,0,4.25|-4.25,0,-4.125|-4.25,0,-3.5|-4.25,0,-2.5|-4.25,0,2.5|-4.25,0,3.5|-4.25,0,4.125|-4.375,0,-4|-4.375,0,-3.5|-4.375,0,-3.25|-4.375,0,-3.125|-4.375,0,-3|-4.375,0,-2.875|-4.375,0,-2.75|-4.375,0,-2.5|-4.375,0,2.5|-4.375,0,2.75|-4.375,0,2.875|-4.375,0,3|-4.375,0,3.125|-4.375,0,3.25|-4.375,0,3.375|-4.375,0,3.5|-4.375,0,4|-4.5,0,-3.875|-4.5,0,-3.75|-4.5,0,-3.5|-4.5,0,-3.375|-4.5,0,-3.25|-4.5,0,-2.75|-4.5,0,-2.625|-4.5,0,-2.5|-4.5,0,2.5|-4.5,0,2.625|-4.5,0,2.75|-4.5,0,3.25|-4.5,0,3.375|-4.5,0,3.5|-4.5,0,3.75|-4.5,0,3.875|-4.625,0,-3.75|-4.625,0,-3.625|-4.625,0,-3.5|-4.625,0,-2.5|-4.625,0,-2.375|-4.625,0,2.375|-4.625,0,2.5|-4.625,0,3.5|-4.625,0,3.625|-4.625,0,3.75|-4.75,0,-3.625|-4.75,0,-2.375|-4.75,0,2.375|-4.75,0,3.625|-4.875,0,-3.75|-4.875,0,-3.625|-4.875,0,-2.375|-4.875,0,-2.25|-4.875,0,2.25|-4.875,0,2.375|-4.875,0,3.625|-4.875,0,3.75|-5,0,-3.75|-5,0,-2.25|-5,0,2.25|-5,0,3.75|-5.125,0,-3.75|-5.125,0,-2.25|-5.125,0,-2.125|-5.125,0,-2|-5.125,0,-1.875|-5.125,0,-1.75|-5.125,0,-1.625|-5.125,0,-1.5|-5.125,0,-1.375|-5.125,0,-1.25|-5.125,0,-1.125|-5.125,0,-1|-5.125,0,-0.875|-5.125,0,-0.75|-5.125,0,-0.625|-5.125,0,-0.5|-5.125,0,-0.375|-5.125,0,-0.25|-5.125,0,-0.125|-5.125,0,0|-5.125,0,0.125|-5.125,0,0.25|-5.125,0,0.375|-5.125,0,0.5|-5.125,0,0.625|-5.125,0,0.75|-5.125,0,0.875|-5.125,0,1|-5.125,0,1.125|-5.125,0,1.25|-5.125,0,1.375|-5.125,0,1.5|-5.125,0,1.625|-5.125,0,1.75|-5.125,0,1.875|-5.125,0,2|-5.125,0,2.125|-5.125,0,2.25|-5.125,0,3.75|-5.25,0,-3.75|-5.25,0,-2.25|-5.25,0,2.25|-5.25,0,3.75|-5.375,0,-3.75|-5.375,0,-3.625|-5.375,0,-2.375|-5.375,0,-2.25|-5.375,0,2.25|-5.375,0,2.375|-5.375,0,3.625|-5.375,0,3.75|-5.5,0,-3.625|-5.5,0,-2.375|-5.5,0,-2.25|-5.5,0,-2.125|-5.5,0,2.125|-5.5,0,2.25|-5.5,0,2.375|-5.5,0,3.625|-5.625,0,-3.625|-5.625,0,-3.5|-5.625,0,-2.5|-5.625,0,-2.375|-5.625,0,-2|-5.625,0,-1.875|-5.625,0,-1.75|-5.625,0,1.75|-5.625,0,1.875|-5.625,0,2|-5.625,0,2.375|-5.625,0,2.5|-5.625,0,3.5|-5.625,0,3.625|-5.75,0,-3.5|-5.75,0,-3.375|-5.75,0,-3.25|-5.75,0,-2.75|-5.75,0,-2.625|-5.75,0,-2.5|-5.75,0,-1.625|-5.75,0,-1.5|-5.75,0,-1.375|-5.75,0,-1.25|-5.75,0,-1.125|-5.75,0,1.125|-5.75,0,1.25|-5.75,0,1.375|-5.75,0,1.5|-5.75,0,1.625|-5.75,0,2.5|-5.75,0,2.625|-5.75,0,2.75|-5.75,0,3.25|-5.75,0,3.375|-5.75,0,3.5|-5.875,0,-3.25|-5.875,0,-3.125|-5.875,0,-3|-5.875,0,-2.875|-5.875,0,-2.75|-5.875,0,-1.125|-5.875,0,-1|-5.875,0,-0.875|-5.875,0,-0.75|-5.875,0,-0.625|-5.875,0,-0.5|-5.875,0,-0.375|-5.875,0,-0.25|-5.875,0,-0.125|-5.875,0,0|-5.875,0,0.125|-5.875,0,0.25|-5.875,0,0.375|-5.875,0,0.5|-5.875,0,0.625|-5.875,0,0.75|-5.875,0,0.875|-5.875,0,1|-5.875,0,1.125|-5.875,0,2.75|-5.875,0,2.875|-5.875,0,3|-5.875,0,3.125|-5.875,0,3.25|-6,0,0|]>
    - repeat <[frequency]>:
        - define alchtick <server.flag[alchtick].if_null[0]>
        - define location <[location].with_yaw[<[alchtick]>]>
        - foreach <[face]> as:vec:
            - playeffect at:<[location].relative[<[vec]>]> effect:<[particle]> offset:0.0
        - wait <[delay]>
        - define location <[location].with_yaw[1]>


# ps_shape_square:
#     type: task
#     definitions: location|particle|frequency|rotation
#     script:
#     - define location <[location].simple>
#     - switch <[rotation]>:
#         - case top:
#             - define location <[location].above[0.4].with_yaw[90]>
#         - case bottom:
#             - define location <[location].below[0.4].with_yaw[90]>
#         - case north:
#             - define location <[location].with_z[<[location].center.z.sub[0.4]>]>
#         - case east:
#             - define location <[location].with_x[<[location].center.x.add[0.4]>]>
#         - case south:
#             - define location <[location].with_z[<[location].center.z.add[0.4]>]>
#         - case west:
#             - define location <[location].with_z[<[location].center.x.sub[0.4]>]>
#     - define reset <[location]>
#     - define delay <element[1].div[<[frequency]>].as[duration].in_ticks>t
#     - repeat <[frequency]>:
#         - repeat 10:
#             - playeffect at:<[location]> effect:<[particle]> offset:0.0
#             - define location <[location].relative[0.1,0,0]>
#         - repeat 10:
#             - playeffect at:<[location]> effect:<[particle]> offset:0.0
#             - define location <[location].relative[0,0.1,0]>
#         - repeat 10:
#             - playeffect at:<[location]> effect:<[particle]> offset:0.0
#             - define location <[location].relative[-0.1,0,0]>
#         - repeat 10:
#             - playeffect at:<[location]> effect:<[particle]> offset:0.0
#             - define location <[location].relative[0,-0.1,0]>
#         - define location <[reset]>
#         - wait <[delay]>

ps_shape_square:
    type: task
    definitions: location|particle|frequency|rotation
    script:
    - switch <[rotation]>:
        - case bottom:
            - define location <[location].simple>
            - define points <list[]>

ps_shape_square_bottom_tester:
    type: task
    definitions: location
    script:
    #- define location <[location].round_down>
    - repeat 10:
        - playeffect at:<[location]> effect:electric_spark offset:0.0
        - define location <[location].relative[-0.1,0,0]>
    - repeat 10:
        - playeffect at:<[location]> effect:electric_spark offset:0.0
        - define location <[location].relative[0,0,-0.1]>
    - repeat 10:
        - playeffect at:<[location]> effect:electric_spark offset:0.0
        - define location <[location].relative[0.1,0,0]>
    - repeat 10:
        - playeffect at:<[location]> effect:electric_spark offset:0.0
        - define location <[location].relative[0,0,0.1]>