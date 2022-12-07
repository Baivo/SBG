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
        - flag <[player]> perkmenu.perk:<[perk]>
        - flag <[player]> perkmenu.perkname:<[perkname]>
        - note <inventory[Spoints_Perks_levelup]> as:Levelup_<[player]>_<[perk]>
        - inventory open d:<inventory[Levelup_<[player]>_<[perk]>]>

## LevelUP Menu

Spoints_Perks_Levelup_Item_UP:
    type: item
    material: furnace
    display name: <&a>+1 Level
    lore:
    - <&gradient[from=#C7C5FC;to=#C5DFFC]>Click to level up
    flags:
        script: Spoints_PerkUp_precheck

Spoints_PerkUp_precheck:
    type: task
    definitions: player
    script:
        - define cost <[player].flag[perkmenu.cost]>
        - define script Spoints_Perkup
        - run SPoints_shop_transact def.player:<[player]> def.cost:<[cost]> def.script:<[script]>

Spoints_PerkUp:
    type: task
    definitions: player
    script:
        - define perk <[player].flag[perkmenu.perk]>
        - if <[perk]> <= 9:
            - flag <[player]> <[perk]>:+
            - narrate targets:<[player]> "<&a>You have leveled up your <[player].flag[perkmenu.perkname]> to level <&e><[player].flag[perkmenu.perk]>"
        - else:
            - narrate targets:<[player]> "<&c>You have reached the max level for this perk"
            - flag <[player]> perkmenu.perk:!
            - flag <[player]> perkmenu.perkname:!
            - inventory close


## Perks
Spoints_Perks_Menu_Item_FurnaceSpeed:
    type: item
    material: furnace
    display name: <&gradient[from=#C7C5FC;to=#C5DFFC]>Furnace Speed
    lore:
    - <&gradient[from=#C7C5FC;to=#C5DFFC]>Click to open Level-Up menu
    flags:
        script: SPoints_Perks_Menu_FurnaceSpeed_Script

SPoints_Perks_Menu_FurnaceSpeed_Script:
    type: task
    definitions: player
    script:
        - run Spoints_Perks_levelup_script def.cost:100 def.perk:perks.smelt.speed def.player:<[player]> def.perkname:Furnace<&sp>Speed
