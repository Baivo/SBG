# Author: Baivo
# In development, don't touch, don't give them out, don't use them yourself!

# Attempted to troubleshoot GUI not updating name correctly on use. Suspect it may be to do with Mergu, but need to determine if I'm at fault first, as is usually the case. 

Logger_Script:
    type: task
    debug: false
    definitions: logger|owner-
    script:
    - define power <[logger].flag[logger]>
    - define range <[logger].flag[range]>
    - if <[power]> == Off:
        - stop
    - else:
        - foreach <[logger].find_blocks_flagged[loggertarget].within[<[range]>]> as:tree:
            - define sapling <[tree].flag[loggersapling]>
            - foreach <[tree].flag[loggertarget]> as:target:
                - if <util.random_chance[10]>:
                    - playeffect effect:SWEEP_ATTACK at:<[target]> visibility:100
                    - playsound <[logger]> sound:ITEM_AXE_SCRAPE volume:0.7
                - adjust <[target]> coreprotect_log_removal:[user=Denizen;material=<[target].material.name>]
                - if ( <[target].material.name> == air ) || ( <[target].material.name> == dirt ) || ( <[target].material.name.contains_any[grass_block]> ) || ( <[target].material.name> == podzol ) || ( <[target].material.name> == coarse_dirt ):
                    - foreach next
                - modifyblock <[target]> air naturally:diamond_axe delayed
            - modifyblock <[tree]> <[sapling]> naturally:diamond_axe delayed
            - flag <[tree]> loggersapling:!
            - flag <[tree]> loggertarget:!

Logger_Events:
    type: world
    debug: false
    events:
        on delta time secondly every:5:
        - foreach <server.flag[logger].if_null[<list>]> as:logger:
            - run Logger_script def.logger:<[logger]> def.owner:<[logger].flag[owner]>
        on player places Logger_Item:
        - define location <context.location>
        - flag server logger:->:<[location]>
        - flag <context.location> logger:On
        - flag <context.location> range:5
        - flag <context.location> owner:<player>
        - define id <util.random_uuid>
        - flag server particle_stick_location:->:<[location]>
        - flag <[location]> particle.id:->:<[id]>
        - flag <[location]> particle.<[id]>.owner:<player.name>
        - flag <[location]> particle.<[id]>.particle:SMOKE_NORMAL
        - flag <[location]> particle.<[id]>.frequency:5
        - flag <[location]> particle.<[id]>.shape:circle
        - flag <[location]> particle.<[id]>.rotation:bottom
        on player breaks stonecutter location_flagged:Logger:
        - define location <context.location>
        - flag server logger:<-:<[location]>
        - flag <[location]> logger:!
        - flag <[location]> range:!
        - flag <[location]> owner:!
        - flag server particle_stick_location:<-:<[location]>
        - flag <[location]> particle:!
        - determine <item[Logger_Item]>
        on player right clicks stonecutter location_flagged:Logger:
        - determine cancelled passively
        - define logger <context.location>
        - define owner <[logger].flag[owner]>
        - define menu <inventory[logger_menu]>
        - flag <player> logger_menu:<[menu]>
        - flag <player> logger_menu_logger:<[logger]>
        - define range <[logger].flag[range]>
        - if <[logger].flag[logger]> == on:
            - adjust <inventory[<player.flag[logger_menu]>]> title:<&3>Logger<&7><&l><&sp>|<&sp><&7>Range:<&sp><&e><[range]><&7><&l><&sp>|<&sp><&7>Power:<&sp><&a>On
        - else:
            - adjust <inventory[<player.flag[logger_menu]>]> title:<&3>Logger<&7><&l><&sp>|<&sp><&7>Range:<&sp><&e><[range]><&7><&l><&sp>|<&sp><&7>Power:<&sp><&c>Off
        - wait 1t
        - inventory open d:<inventory[<player.flag[logger_menu]>]>
        on structure grows:
        - flag <context.location> loggersapling:<context.location.material.name>
        - flag <context.location> loggertarget:<context.blocks>

Logger_Menu_Script:
    type: world
    debug: false
    events:
        on player clicks Logger_RangeUp in logger_menu:
        - define logger <player.flag[logger_menu_logger]>
        - define range <[logger].flag[range]>
        - if <[range]> < 16:
            - flag <[logger]> range:<[range].add[1]>
            - define range <[logger].flag[range]>
            - if <[logger].flag[logger]> == on:
                - adjust <inventory[<player.flag[logger_menu]>]> title:<&3>Logger<&7><&l><&sp>|<&sp><&7>Range:<&sp><&e><[range]><&7><&l><&sp>|<&sp><&7>Power:<&sp><&a>On
            - else:
                - adjust <inventory[<player.flag[logger_menu]>]> title:<&3>Logger<&7><&l><&sp>|<&sp><&7>Range:<&sp><&e><[range]><&7><&l><&sp>|<&sp><&7>Power:<&sp><&c>Off
            - wait 1t
            - inventory open d:<inventory[<player.flag[logger_menu]>]>
        - else:
            - narrate "<&a>Already at max range"
            - inventory close
        on player clicks Logger_RangeDown in logger_menu:
        - define logger <player.flag[logger_menu_logger]>
        - define range <[logger].flag[range]>
        - if <[range]> >= 1:
            - flag <[logger]> range:<[range].sub[1]>
            - define range <[logger].flag[range]>
            - if <[logger].flag[logger]> == on:
                - adjust <inventory[<player.flag[logger_menu]>]> title:<&3>Logger<&7><&l><&sp>|<&sp><&7>Range:<&sp><&e><[range]><&7><&l><&sp>|<&sp><&7>Power:<&sp><&a>On
            - else:
                - adjust <inventory[<player.flag[logger_menu]>]> title:<&3>Logger<&7><&l><&sp>|<&sp><&7>Range:<&sp><&e><[range]><&7><&l><&sp>|<&sp><&7>Power:<&sp><&c>Off
            - wait 1t
            - inventory open d:<inventory[<player.flag[logger_menu]>]>
        - else:
            - narrate "<&c>Already at min range"
            - inventory close
        on player clicks Logger_Power in logger_menu:
        - define location <player.flag[logger_menu_logger]>
        - if <[location].flag[logger]> == On:
            - flag <[location]> logger:Off
            - narrate "<&c>Logger off"
            - inventory close
            - flag server particle_stick_location:<-:<[location]>
            - flag <[location]> particle:!
        - else:
            - flag <[location]> Logger:On
            - narrate "<&a>Logger on"
            - inventory close
            - define id <util.random_uuid>
            - flag server particle_stick_location:->:<[location]>
            - flag <[location]> particle.id:->:<[id]>
            - flag <[location]> particle.<[id]>.owner:<player.name>
            - flag <[location]> particle.<[id]>.particle:SMOKE_NORMAL
            - flag <[location]> particle.<[id]>.frequency:5
            - flag <[location]> particle.<[id]>.shape:circle
            - flag <[location]> particle.<[id]>.rotation:bottom

Logger_RangeUp:
    type: item
    material: soul_torch
    display name: <&b>Range up

Logger_RangeDown:
    type: item
    material: redstone_torch
    display name: <&c>Range down

Logger_Power:
    type: item
    material: lever
    display name: <&2>Toggle Power

Logger_Item:
    type: item
    material: stonecutter
    display name: <&9>Auto-Logger
    lore:
    - Harvests trees grown by saplings
    - <&7>Right click to open menu
    - <&7>Break to remove
    mechanisms:
        custom_model_data: 17
    recipes:
        1:
            type: shapeless
            input: barrier|stonecutter

Logger_Menu:
    type: inventory
    inventory: hopper
    title: <&a><&l>Logger Menu
    size: 5
    gui: true
    slots:
    - [Logger_RangeDown] [] [Logger_Power] [] [Logger_RangeUp]
