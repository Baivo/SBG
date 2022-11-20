# Author: Baivo
# In development, don't touch, don't give them out, don't use them yourself!

# Attempted to troubleshoot GUI not updating name correctly on use. Suspect it may be to do with Mergu, but need to determine if I'm at fault first, as is usually the case. 

Logger_Script:
    type: task
    debug: false
    definitions: logger|owner
    script:
    - define power <[logger].flag[Logger]>
    - define range <[logger].flag[Range]>
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
            - modifyblock <[tree]> <[sapling]> naturally:hand delayed
            - flag <[tree]> loggersapling:!
            - flag <[tree]> loggertarget:!

Logger_Events:
    type: world
    debug: false
    events:
        on delta time secondly every:5:
        - foreach <server.flag[Logger]> key:logger as:owner:
            - run Logger_script def.logger:<[logger]> def.owner:<[owner]>
        on player places Logger_Item:
        - flag server Logger.<context.location>:<player>
        - flag <context.location> Logger:On
        - flag <context.location> Range:5
        on player breaks stonecutter location_flagged:Logger:
        - flag server Logger.<context.location>:!
        - flag <context.location> Logger:!
        - flag <context.location> Range:!
        - determine <item[Logger_Item]>
        on player right clicks stonecutter location_flagged:Logger:
        - determine cancelled passively
        - define logger <context.location>
        - define owner <server.flag[Logger.<context.location>]>
        # - if <player> != <[owner]>:
        #     - narrate "not yours"
        #     - determine cancelled
        # - else:
        #     - narrate yours
        - flag <player> Logger_menu:<[logger]>
        - note remove as:Logger_Menu_<context.location>
        - note <inventory[Logger_Menu]> as:Logger_Menu_<context.location>
        - wait 1t
        - adjust <inventory[Logger_Menu_<context.location>]> "title:<&a>Logger Menu<&7><&sp>Range: <&e><[logger].flag[Range]>"
        - wait 1t
        - inventory open d:Logger_Menu_<context.location>
        on structure grows:
        - flag <context.location> loggersapling:<context.location.material.name>
        - flag <context.location> loggertarget:<context.blocks>

Logger_Menu_Script:
    type: world
    debug: true
    events:
        on player clicks Logger_RangeUp in Logger_Menu_*:
        - define logger <player.flag[Logger_Menu]>
        - define range <[logger].flag[Range]>
        - if <[range]> < 16:
            - flag <[logger]> Range:<[range].add[1]>
            - adjust <inventory[Logger_Menu_<context.location>]> "title:<&a>Logger Menu<&7><&sp>Range: <&e><[range]>"
            - wait 1t
            - inventory open d:Logger_Menu_<context.location>
        - else:
            - narrate "<&a>Already at max range"
            - inventory close
        on player clicks Logger_RangeDown in Logger_Menu_*:
        - define logger <player.flag[Logger_Menu]>
        - define range <[logger].flag[Range]>
        - if <[range]> > 1:
            - flag <[logger]> Range:<[range].sub[1]>
            - adjust <inventory[Logger_Menu_<context.location>]> "title:<&a>Logger Menu<&sp><&7>Range: <&e><[range]>"
            - wait 1t
            - inventory open d:Logger_Menu_<context.location>
        - else:
            - narrate "<&c>Already at min range"
            - inventory close
        on player clicks Logger_Power in Logger_Menu_*:
        - define logger <player.flag[Logger_Menu]>
        - if <[logger].flag[Logger]> == On:
            - flag <[logger]> Logger:Off
            - narrate "<&c>Logger off"
            - inventory close
        - else:
            - flag <[logger]> Logger:On
            - narrate "<&a>Logger on"
            - inventory close

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
    display name: <&9>Logger
    lore:
    - logs logs
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
    - [] [Logger_RangeUp] [Logger_Power] [Logger_RangeDown] []
