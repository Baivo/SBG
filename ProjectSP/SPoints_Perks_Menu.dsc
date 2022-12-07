SPoints_Perks_menu:
    type: inventory
    title: <&gradient[from=#C7C5FC;to=#C5DFFC]>Perks Shop
    inventory: chest
    size: 18
    gui: true
    data:
        menu: Spoints_perks_menu

Spoints_perks_menu_events:
    type: world
    events:
        on player clicks SPoints_Perks_Menu_Item_* in Spoints_Perks_menu:
        - ratelimit <player> 1s
        - define script <context.item.flag[script]>
        - run <[script]> def.player:<player>
        on player clicks SPoints_Perks_Menu_Item_Main in Spoints_shop:
        - ratelimit <player> 1s
        - define script <context.item.flag[script]>
        - run <[script]> def.player:<player>

SPoints_Perks_Menu_Command:
    type: command
    name: perks
    description: Open the perks shop
    usage: /perks
    script:
    - note <inventory[Spoints_Perks_Menu]> as:Spoints_Perks_Menu_<player>
    - inventory open d:<inventory[Spoints_Perks_Menu_<player>]>

SPoints_Perks_Menu_Item_Main:
    type: item
    material: experience_bottle
    display name: <&gradient[from=#C7C5FC;to=#C5DFFC]>Perks
    lore:
    - <&gradient[from=#C7C5FC;to=#C5DFFC]>Click to open the perks menu
    flags:
        script: SPoints_Perks_Menu_Script

SPoints_Perks_Menu_Script:
    type: task
    definitions: player
    script:
        - execute as_player perks
