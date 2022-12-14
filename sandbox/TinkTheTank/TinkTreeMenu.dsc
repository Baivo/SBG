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
        on player places block:
        - if <context.item_in_hand.has_flag[tinktreeitem]>:
            - flag <context.location> tinktreeitem:<player.name>
        on player breaks block location_flagged:tinktreeitem:
        - flag <context.location> tinktreeitem:!

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