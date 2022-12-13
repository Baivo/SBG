SPoints_Perks_menu:
    type: inventory
    title: <&gradient[from=#C7C5FC;to=#C5DFFC]>Perks Shop
    inventory: chest
    size: 9
    gui: true
    data:
        menu: Spoints_perks_menu

Spoints_perks_menu_events:
    type: world
    events:
        on player clicks SPoints_Perks_Menu_Item_* in Spoints_Perks_menu:
        - ratelimit <player> 1s
        - run <context.item.flag[script]> def.player:<player>
        on player clicks SPoints_Perks_Menu_Item_Main in Spoints_shop:
        - ratelimit <player> 1s
        - define script <context.item.flag[script]>
        - run <[script]> def.player:<player>
        on player clicks item in SPoints_Perks_levelup:
        - ratelimit <player> 1s
        - run <context.item.flag[script]> def.player:<player>

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
    definitions: perk|player|perkname|cost
    script:
        - flag <[player]> perkmenu.perk:<[perk]>
        - flag <[player]> perkmenu.perkname:<[perkname]>
        - flag <[player]> perkmenu.cost:<[cost]>
        - note <inventory[Spoints_Perks_levelup]> as:Levelup_<[player]>_<[perk]>
        - inventory open d:<inventory[Levelup_<[player]>_<[perk]>]>

## LevelUP Menu

Spoints_Perks_Levelup_Item_UP:
    type: item
    material: lime_stained_glass_pane
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
        - define perk <[player].flag[perkmenu.perk]>
        - define perklevel:<[player].flag[<[perk]>].if_null[1]>
        - if <[perklevel]> <= 19:
            - run SPoints_shop_transact def.player:<[player]> def.cost:<[cost]> def.script:<[script]>
        - else:
            - narrate targets:<[player]> "<&c>You have reached the max level for this perk"
            - flag <[player]> perkmenu.perk:!
            - flag <[player]> perkmenu.perkname:!
            - inventory close

Spoints_PerkUp:
    type: task
    definitions: player
    script:
        - define perk <[player].flag[perkmenu.perk]>
        - define perklevel:<[player].flag[<[perk]>].if_null[1]>
        - flag <[player]> <[player].flag[perkmenu.perk]>:++
        - narrate targets:<[player]> "<&a>You have leveled up your <[player].flag[perkmenu.perkname]> to level <&e><[player].flag[<[perk]>]>"
        - run Perk_refresh def.player:<[player]> def.perk:<[perk]>
        - inventory open d:<inventory[Levelup_<[player]>_<[perk]>]>

Perk_refresh:
    type: task
    definitions: player|perk
    script:
        - choose <[perk]>:
            - case perks.attributes.health:
                - run perks_attributes_tasks def.player:<[player]> def.perk:<[perk]>

Spoints_Perks_Levelup_Item_DOWN:
    type: item
    material: orange_stained_glass_pane
    display name: <&6>-1 Level
    lore:
    - <&gradient[from=#C7C5FC;to=#C5DFFC]>Click to refund a level
    - <&7>Returns 75% of the cost to your balance
    flags:
        script: Spoints_PerkDown_precheck

Spoints_Perkdown_precheck:
    type: task
    definitions: player
    script:
        - define cost <[player].flag[perkmenu.cost]>
        - define script Spoints_Perkup
        - define perk <[player].flag[perkmenu.perk]>
        - define perklevel:<[player].flag[<[perk]>].if_null[1]>
        - if <[perklevel]> >= 2:
            - define refund <[cost].mul[0.75].round_to[0]>
            - flag <[player]> <[player].flag[perkmenu.perk]>:--
            - execute as_server "spoints add <[player].name> <[refund]>"
            - narrate targets:<[player]> "<&a>You have refunded your <[player].flag[perkmenu.perkname]> to level <&e><[player].flag[<[perk]>]>"
            - inventory open d:<inventory[Levelup_<[player]>_<[perk]>]>
        - else:
            - narrate targets:<[player]> "<&c>You have reached the min level for this perk"
            - flag <[player]> perkmenu.perk:!
            - flag <[player]> perkmenu.perkname:!
            - inventory close
