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
        on player clicks item in SPoints_Perks_levelup:
        - announce to_flagged:Baivo <context.slot>

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
##

SPoints_Perks_LevelUp:
    type: inventory
    title: <&gradient[from=#C7C5FC;to=#C5DFFC]>Level Up
    inventory: hopper
    size: 5
    gui: true
    data:
        menu: Spoints_perks_levelup

Spoints_Perks_levelup_script:
    type: task
    debug: true
    definitions: perk|player|perkname
    script:
        - note <inventory[Spoints_Perks_levelup]> as:Levelup_<[player]>_<[perk]>
        - define inv <inventory[Levelup_<[player]>_<[perk]>]>
        - adjust <[inv]> "title:<&gradient[from=#C7C5FC;to=#C5DFFC]>Level Up <&7><&l><&gt><&gt><&e> <[perkname]>"
        - inventory adjust "display:<&7>Current Level: <&e><[player].flag[<[perk]>].if_null[1]>" d:<[inv]> slot:3
        #
        - inventory open d:<[inv]>
        - inventory update

##


Spoints_Perks_Menu_Item_FurnaceSpeed:
    type: item
    material: furnace
    display name: <&gradient[from=#C7C5FC;to=#C5DFFC]>Furnace Speed
    lore:
    - <&gradient[from=#C7C5FC;to=#C5DFFC]>Click to open Level-Up menu
    flags:
        script: SPoints_Perks_Menu_Smelting_Script

SPoints_Perks_Menu_Smelting_Script:
    type: task
    definitions: player
    script:
        - run Spoints_Perks_levelup_script def.perk:perks.smelt.speed def.player:<[player]> def.perkname:Furnace<&sp>Speed
