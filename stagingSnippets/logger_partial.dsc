Logger_Script:
    type: task
    debug: true
    script:
    - narrate hi
    # 	<MaterialTag.persistent> returns if a material will decay from being too far away from tree.
    #  	<LocationTag.coreprotect_logs[<duration>]>
    # - foreach <player.location.coreprotect_logs[12h]> as:entry:
    # - narrate "found <[entry]>"

Logger_Events:
    type: world
    debug: true
    events:
        on delta time secondly every:1:
        - foreach <server.flag[Logger]> key:logger as:owner:
            - run Logger_script logger:<[logger]> owner:<[owner]>
        on player places Logger_Item:
        - flag server Logger.<context.location>:<player>
        - flag <context.location> Logger:On
        - flag <context.location> Range:5
        on player breaks stonecutter location_flagged:Logger:
        - flag server Logger.<context.location>:!
        - flag <context.location> Logger:!
        on player right clicks stonecutter location_flagged:Logger:
        - define logger <context.location>
        - define owner <server.flag[Logger.<context.location>]>
        - if <player> != <[owner]>:
            - narrate "not yours"
            - determine cancelled
        - else:
            - narrate yours
            - flag <player> Logger_menu:<[logger]>
            - inventory open d:Logger_Menu

Logger_Menu_Script:
    type: world
    debug: false
    events:
        on player clicks Logger_RangeUp in Logger_Menu:
        - define logger <player.flag[Logger_Menu]>
        - define range <[logger].flag[Range]>
        - if <[range]> < 16:
            - flag <[logger]> Range:<[range].add[1]>
            - narrate "range up"
        - else:
            - narrate "Already at max range"
        on player clicks Logger_RangeDown in Logger_Menu:
        - define logger <player.flag[Logger_Menu]>
        - define range <[logger].flag[Range]>
        - if <[range]> > 1:
            - flag <[logger]> Range:<[range].sub[1]>
            - narrate "range down"
        - else:
            - narrate "Already at min range"
        on player clicks Logger_Power in Logger_Menu:
        - define logger <player.flag[Logger_Menu]>
        - if <[logger].flag[Logger]> == On:
            - flag <[logger]> Logger:Off
            - narrate "Logger off"
        - else:
            - flag <[logger]> Logger:On
            - narrate "Logger on"

Logger_RangeUp:
    type: item
    material: stone
    display name: <&9>Range up

Logger_RangeDown:
    type: item
    material: stone
    display name: <&9>Range down

Logger_Power:
    type: item
    material: stone
    display name: <&9>Toggle Power

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
    inventory: dispenser
    title: <&9>Logger Menu
    size: 9
    gui: true
    slots:
    - [Logger_RangeUp] [Logger_Power] [Logger_RangeDown]
    - [] [] []
    - [] [] []
