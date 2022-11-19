# Author: Baivo#1337
# Version 2.1
# Requries Mergu's 'In-game Menu / GUI Creator', or adjust the shop menu to work with your own GUI setup.
# https://forum.denizenscript.com/resources/in-game-menu-gui-creator.123/

# 2.1 Updated to fix compatibility issues with Mergu's menu editor

## SPoints - Point System
SP_start:
    type: world
    events:
        on player joins:
        - if !<player.has_flag[SP_balance]>:
            - flag <player> SP_balance:0
        - else:
            - flag <player> SP_balance:<player.flag[SP_balance]>

SP_clock:
    type: world
    events:
        on delta time minutely:
        - foreach <server.online_players> as:player:
            - define SP_balance <[player].flag[SP_balance]>
            - if !<[player].has_flag[SP]>:
                - flag <[player]> SP:1
            - else if <[player].flag[SP]> >= 9:
                - flag <[player]> SP:1
                - flag <[player]> SP_balance:+:10
                - actionbar "<&7>You earned <&e>10 SP <&7>for 10 minutes online time" targets:<[player]>
            - else if <[player].flag[SP]> <= 9:
                - flag <[player]> SP:++

spoints_command:
    type: command
    name: spoints
    debug: false
    description: Adjust second currency
    usage: /spoints action player amount
    permisison: spoints.admin
    tab completions:
        1: add|remove|set|get|list
        2: <server.online_players.parse[name]>
        3: 10|20|30|40|50|60|70|80|90|100
    script:
    - if !<context.args.get[1]> != list:
        - if !<server.online_players.formatted.contains[<context.args.get[2]>]>:
            - narrate "<&c>Player not found!"
            - stop
    - if !<context.args.get[3].is_integer>:
        - narrate "<&c>Amount must be a number!"
    - else:
        - define player <player[<context.args.get[2]>]>
    - if <context.args.get[1]> == add:
        - flag <[player]> SP_balance:+:<context.args.get[3]>
        - narrate "<&e>Added <&a><context.args.get[3]> <&e>to <[player].display_name><&e>'s SP balance!"
        - narrate "<&e>They now have <&a><[player].flag[SP_balance]> <&e>SP!"
        - narrate "<&a><context.args.get[3]><&e> has been added to your server point balance!" targets:<player[<[player]>]>
    - if <context.args.get[1]> == remove:
        - flag <[player]> SP_balance:-:<context.args.get[3]>
        - narrate "<&e>Removed <&c><context.args.get[3]> <&e>from <[player].display_name><&e>'s SP balance!"
        - narrate "<&e>They now have <&a><[player].flag[SP_balance]> <&e>SP!"
        - narrate "<&c><context.args.get[3]><&e> has been removed from your server point balance!" targets:<player[<[player]>]>
    - if <context.args.get[1]> == set:
        - flag <[player]> SP_balance:<context.args.get[3]>
        - narrate "<&e>Set <[player].display_name><&e>'s SP balance to <&a><context.args.get[3]><&e>!"
        - narrate "<&e>Your server point balance has been set to <[player].flag[SP_balance]>!" targets:<player[<[player]>]>
    - if <context.args.get[1]> == get:
        - narrate "<&e><[player].display_name><&e>'s SP balance is <&a><[player].flag[SP_balance]><&e>!"
    - if <context.args.get[1]> == list:
        - narrate "<&e>Server Point Balances:<&nl>"
        - foreach <server.online_players> as:player:
            - narrate <[player].display_name><&sp><&7><&gt><&sp><&a><[player].flag[SP_balance]>

## SPoints - Shop Menu

SPoints_shop_command:
    type: command
    name: redeem
    debug: true
    description: Open the Point Shop
    usage: /redeem
    script:
    - run SPoints_shop_update def.inv:<inventory[SPoints_Shop_<player.name>]> def.player:<player>

SPoints_shop_transact:
    type: task
    debug: false
    definitions: player|cost|script
    script:
    - if <[player].flag[SP_Balance]> >= <[cost]>:
        - actionbar "<&c><[cost]><&e> points subtracted from your balance!" targets:<[player]>
        - flag <[player]> SP_Balance:-:<[cost]>
        - run <[script]> def.player:<[player]>
    - else:
        - narrate "<&c>Not enough points!" targets:<[player]>
        - inventory close d:<inventory[SPoints_Shop_<[player].name>]>

SPoints_shop_update:
    type: task
    definitions: player|inv
    script:
        - flag server SPoints.<[player].name>:<inventory[<[inv]>]>
        - note <inventory[<server.flag[SPoints.<[player].name>]>]> as:SPoints_Shop_<[player].name>
        - adjust <[inv]> "title:<&a>Point Shop <&7>| <&a>Balance: <&3><[player].flag[SP_balance]>"
        - inventory open d:SPoints_Shop_<[player].name>

SPoints_Shop:
    type: inventory
    inventory: chest
    title: <&a>Point Shop
    size: 18
    gui: true
    data:
        menu: SPoints_menu

spoints_shop_events:
    type: world
    debug: false
    events:
        on player clicks SPoints_Shop_Item_* in SPoints_Shop_*:
            - ratelimit <player> 1s
            - run spoints_shop_transact def.player:<player> def.cost:<context.item.flag[cost]> def.script:<script[<context.item.flag[script]>]>
            - inventory close d:<inventory[Spoints_Shop_<player.name>]>

## SPoints - Items & Scripts
# Row1 - Slot1 - Night Vision
spoints_shop_item_nightvision:
    type: item
    material: golden_carrot
    display name: <&color[#396902]>Night vision!
    lore:
    - <&sp>
    - <&7>Costs: <&a>10 <&7>points
    - <&sp>
    - <&7><&o>Lasts until death
    flags:
        cost: 10
        script: spoints_shop_script_nightvision

spoints_shop_script_nightvision:
    type: task
    debug: false
    definitions: player
    script:
        - cast NIGHT_VISION amplifier:0 d:999999 hide_particles <[player]>
        - narrate "<&color[#396902]>Night vision enabled.<&nl>Don't forget to still place torches." targets:<[player]>

# Row1 - Slot 2 - Fire Resistance
spoints_shop_item_fireresistance:
    type: item
    material: golden_carrot
    display name: <element[Fire Resistance!].color_gradient[FROM=#944612;TO=#7d2500]>
    lore:
    - <&sp>
    - <&7>Costs: <&a>30 <&7>points
    - <&sp>
    - <&7><&o>Lasts until death
    flags:
        cost: 10
        script: spoints_shop_script_fireresistance

spoints_shop_script_fireresistance:
    type: task
    debug: false
    definitions: player
    script:
        - cast FIRE_RESISTANCE amplifier:0 d:999999 hide_particles <[player]>
        - narrate "<&color[#c73c02]>Nice Work, hot stuff!" targets:<[player]>

# Row1 - Slot8 - Day
spoints_shop_item_day:
    type: item
    material: clock
    display name: <&e>Make it Day-Time!
    lore:
    - <&sp>
    - <&7>Costs: <&a>10 <&7>points
    flags:
        cost: 10
        script: spoints_shop_script_day

spoints_shop_script_day:
    type: task
    debug: false
    definitions: player
    script:
        - time 0
        - narrate "<&a>Time set to day! Hope you were wearing sunglasses!" targets:<[player]>

# Row1 - Slot9 - Healthup
spoints_shop_item_healthup:
    type: item
    material: red_dye
    display name: <&c>Upgrade your max health!
    lore:
    - <&sp>
    - <&7>Costs: <&a>250 <&7>points
    flags:
        cost: 10
        script: spoints_shop_script_healthup

spoints_shop_script_healthup:
    type: task
    debug: false
    definitions: player
    script:
        - adjust <[player]> max_health:<player.health_max.add_int[2]>
        - narrate "<&a>Your maximum HP is now <&c><player.health_max.div[2]><&a> hearts!" targets:<[player]>
