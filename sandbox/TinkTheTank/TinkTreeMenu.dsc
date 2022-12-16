Tink_tree_menu:
    type: inventory
    title: <&gradient[from=#C7C5FC;to=#C5DFFC]>Choose a category<&co>
    inventory: hopper
    size: 5
    gui: true
    data:
        menu: Tink_tree_MainMenu

Tink_tree_menu_events:
    type: world
    events:
        on player clicks item in tink_tree_menu:
        - ratelimit <player> 1s
        - choose <context.slot>:
            - case 1:
                - inventory open d:Tink_tree_page1
            - case 2:
                - inventory open d:Tink_tree_page2
            - case 3:
                - inventory open d:Tink_tree_page3
            - case 4:
                - inventory open d:Tink_tree_page4
            - case 5:
                - inventory open d:Tink_tree_page5
        on player clicks item in tink_tree_page*:
        - ratelimit <player> 5t
        - define item <context.item.with_flag[tinktreeitem]>
        - drop <[item]> <player.location> quantity:<[item].material.max_stack_size>

Tink_tree_page1:
    type: inventory
    title: <&gradient[from=#C7C5FC;to=#C5DFFC]>Build your ornament!<&co>
    inventory: chest
    size: 54
    gui: true
    data:
        menu: Tink_tree_page1

Tink_tree_page2:
    type: inventory
    title: <&gradient[from=#C7C5FC;to=#C5DFFC]>Build your ornament!<&co>
    inventory: chest
    size: 54
    gui: true
    data:
        menu: Tink_tree_page2

Tink_tree_page3:
    type: inventory
    title: <&gradient[from=#C7C5FC;to=#C5DFFC]>Build your ornament!<&co>
    inventory: chest
    size: 54
    gui: true
    data:
        menu: Tink_tree_page3

Tink_tree_page4:
    type: inventory
    title: <&gradient[from=#C7C5FC;to=#C5DFFC]>Build your ornament!<&co>
    inventory: chest
    size: 54
    gui: true
    data:
        menu: Tink_tree_page4

Tink_tree_page5:
    type: inventory
    title: <&gradient[from=#C7C5FC;to=#C5DFFC]>Build your ornament!<&co>
    inventory: chest
    size: 54
    gui: true
    data:
        menu: Tink_tree_page5

Tink_Tree_Menu_Command:
    type: command
    name: ttm
    permission: tinktree.menu
    permission message: <&c>Member rank is required to access materials. Please contact Tink for assistance.
    description: Open the tink tree menu
    usage: /ttm
    script:
    - inventory open d:Tink_Tree_menu

## Command to search for tinktree menu items and blocks
Tink_Tree_cjecler_Command:
    type: command
    name: bivttms
    permission: bivttms
    permission message: <&c>No.
    description: Yes
    usage: /bivttms
    script:
    - foreach <server.worlds> as:world:
        - foreach <[world].loaded_chunks> as:chunk:
            - foreach <[chunk].blocks_flagged[tinktreeitem]> as:block:
                - narrate "<&a>Found a tinktree menu item block at <&e><[block].location>"
                - narrate "<&a>Block is <&e><[block].material> placed by <[block].flag[tinktreeitem]>"
                # clickable to teleport to location
                - clickable def.block:<[block]> save:toblock:
                    - teleport <player> <[block]>
                    - narrate "<&a>Teleported to <&e><[block].location>"
                - narrate <element[<&a>Click to teleport to <&e><[block].location>].on_click[<entry[toblock]>]>
    - narrate "<&a>Done searching for tinktree menu items and blocks."

## Event to stop players stealing decorations
Tink_Tree_Item_Blocker:
    type: world
    debug: false
    events:
        on player clicks item in inventory:
        - if !<context.item.has_flag[tinktreeitem]>:
            - stop
        - if <context.inventory> != <player.inventory>:
            - determine dirt
        on player drags item in inventory:
        - if !<context.item.has_flag[tinktreeitem]>:
            - stop
        - if <context.inventory> != <player.inventory>:
            - determine cancelled
        on player places block:
        - if <context.item_in_hand.has_flag[tinktreeitem]>:
            - flag <context.location> tinktreeitem:<player.name>
        on player breaks block location_flagged:tinktreeitem:
        - flag <context.location> tinktreeitem:!
        - playeffect at:<context.location> effect:redstone_torch_burnout offset:1.2 quantity:10
        - playeffect at:<context.location> effect:villager_happy offset:1.2 quantity:10
        - playeffect at:<context.location> effect:cloud offset:0.2 quantity:3
        - determine nothing

## Netblock stuff
nbf_util_ttm:
    type: task
    definitions: player
    script:
    - ratelimit <player> 1s
    - flag <player> tinktree expire:1s

nbf_util_ttm_handler:
    type: world
    events:
        on player opens chest flagged:tinktree:
        - ratelimit <player> 1s
        - execute as_server "sudo <player.name> ttm"
