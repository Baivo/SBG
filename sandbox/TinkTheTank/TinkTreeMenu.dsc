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

Tink_tree_page1:
    type: inventory
    title: <&gradient[from=#C7C5FC;to=#C5DFFC]>Build your ornament!<&co>
    inventory: chest
    size: 54
    gui: false
    data:
        menu: Tink_tree_page1

Tink_tree_page2:
    type: inventory
    title: <&gradient[from=#C7C5FC;to=#C5DFFC]>Build your ornament!<&co>
    inventory: chest
    size: 54
    gui: false
    data:
        menu: Tink_tree_page2

Tink_tree_page3:
    type: inventory
    title: <&gradient[from=#C7C5FC;to=#C5DFFC]>Build your ornament!<&co>
    inventory: chest
    size: 54
    gui: false
    data:
        menu: Tink_tree_page3

Tink_tree_page4:
    type: inventory
    title: <&gradient[from=#C7C5FC;to=#C5DFFC]>Build your ornament!<&co>
    inventory: chest
    size: 54
    gui: false
    data:
        menu: Tink_tree_page4

Tink_tree_page5:
    type: inventory
    title: <&gradient[from=#C7C5FC;to=#C5DFFC]>Build your ornament!<&co>
    inventory: chest
    size: 54
    gui: false
    data:
        menu: Tink_tree_page5

Tink_Tree_Menu_Command:
    type: command
    name: ttm
    description: Open the tink tree menu
    usage: /ttm
    script:
    - inventory open d:Tink_Tree_menu