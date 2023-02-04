# Author: Baivo#1337
# Version 2.2
# Requries Mergu's 'In-game Menu / GUI Creator', or adjust the shop menu to work with your own GUI setup.
# https://forum.denizenscript.com/resources/in-game-menu-gui-creator.123/

# 2.1 Updated to fix compatibility issues with Mergu's menu editor

# 2.2 Recreated all items to follow a consistent format for both internal use and external view. New item materials, information and color format. 
# The items and their scripts now follow consistent naming convention to allow running logic through matchables against script names, rather than static assignment
# This means running a single event fire for 'on player clicks spoint_shop_item_* in spoint_menu' for example, as opposed to a static event for each.
#
# Added new items for various potion effects, a day and night set time option and further expanding the menu for future additions.
# There should be work to expand the scope of the SPoints shop and break it into categories, where the home page presents a clean and smaller selection of categories. 
# As it stands, adding items to a single large page is likely to discourage players from investigating it fully and cause information overload. 

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
        - if <server.has_flag[disableSP]>:
            - stop
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
    debug: false
    description: Open the Point Shop
    usage: /redeem
    script:
    - note <inventory[SPoints_Shop]> as:Spoints_Shop_<player>
    - inventory open d:<inventory[SPoints_Shop_<player>]>

SPoints_shop_transact_SP:
    type: task
    debug: false
    definitions: player|cost|script
    script:
    - if <[player].flag[SP_Balance]> >= <[cost]>:
        - execute as_server "spoints remove <[player].name> <[cost]>"
        - run <[script]> def.player:<[player]>
    - else:
        - narrate "<&c>Not enough points!" targets:<[player]>
        - inventory close

SPoints_shop_transact:
    type: task
    debug: false
    definitions: player|cost|script
    script:
    - if <[player].money> >= <[cost]>:
        - execute as_server "eco take <[player].name> <[cost]>"
        - run <[script]> def.player:<[player]>
    - else:
        - narrate "<&c>Not enough money!" targets:<[player]>

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
        on player clicks SPoints_Shop_Item_* in spoints_shop:
            - ratelimit <player> 1s
            - run spoints_shop_transact def.player:<player> def.cost:<context.item.flag[cost]> def.script:<script[<context.item.flag[script]>]>
            - inventory close

## SPoints - Items & Scripts ##

# Gives the player Night Vision until death
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

# Gives the player Fire Resistance until death
spoints_shop_item_fireresistance:
    type: item
    material: magma_cream
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

# Set the server time to day (0 ticks)
spoints_shop_item_day:
    type: item
    material: clock
    display name: <&color[#d9bb64]>Day time!
    lore:
    - <&sp>
    - <&7>Set the time to morning!
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
        - narrate "<&color[#d9bb64]>Time set to day" targets:<[player]>

# Set the server time to night (13000 ticks)
spoints_shop_item_night:
    type: item
    material: clock
    display name: <&color[#3e497d]>Night time!
    lore:
    - <&sp>
    - <&7>Set the time to evening!
    - <&sp>
    - <&7>Costs: <&a>10 <&7>points
    flags:
        cost: 10
        script: spoints_shop_script_night

spoints_shop_script_night:
    type: task
    debug: false
    definitions: player
    script:
        - time 13000
        - narrate "<&color[#3e497d]>Time set to night" targets:<[player]>

# Increase the Player's Max Health
spoints_shop_item_healthup:
    type: item
    material: red_dye
    display name: <&c>Upgrade your max health!
    lore:
    - <&sp>
    - <&7>Costs: <&a>250 <&7>points
    flags:
        cost: 250
        script: spoints_shop_script_healthup

spoints_shop_script_healthup:
    type: task
    debug: false
    definitions: player
    script:
        - adjust <[player]> max_health:<player.health_max.add_int[2]>
        - narrate "<&a>Your maximum HP is now <&c><player.health_max.div[2]><&a> hearts!" targets:<[player]>

# Gives the player Damage Resistance until death
spoints_shop_item_damage_resistance:
    type: item
    material: iron_chestplate
    display name: <&color[#8c897e]>Damage Resistance!
    lore:
    - <&sp>
    - <&7>Costs: <&a>25 <&7>points
    - <&sp>
    - <&7><&o>Lasts until death
    flags:
        cost: 25
        script: spoints_shop_script_damage_resistance

spoints_shop_script_damage_resistance:
    type: task
    debug: false
    definitions: player
    script:
        - cast damage_resistance amplifier:0 d:999999 hide_particles <[player]>
        - narrate "<&color[#8c897e]>Damage Resistance enabled" targets:<[player]>

# Gives the player Haste until death
spoints_shop_item_fast_digging:
    type: item
    material: golden_pickaxe
    display name: <&color[#ebe53b]>Haste!
    lore:
    - <&sp>
    - <&7>Costs: <&a>50 <&7>points
    - <&sp>
    - <&7><&o>Lasts until death
    flags:
        cost: 50
        script: spoints_shop_script_fast_digging

spoints_shop_script_fast_digging:
    type: task
    debug: false
    definitions: player
    script:
        - cast fast_digging amplifier:0 d:999999 hide_particles <[player]>
        - narrate "<&color[#ebe53b]>Haste enabled" targets:<[player]>

# Gives the player Strength until death
spoints_shop_item_increase_damage:
    type: item
    material: netherite_axe
    display name: <&color[#eb8a3b]>Strength!
    lore:
    - <&sp>
    - <&7>Costs: <&a>25 <&7>points
    - <&sp>
    - <&7><&o>Lasts until death
    flags:
        cost: 25
        script: spoints_shop_script_increase_damage

spoints_shop_script_increase_damage:
    type: task
    debug: false
    definitions: player
    script:
        - cast increase_damage amplifier:0 d:999999 hide_particles <[player]>
        - narrate "<&color[#eb8a3b]>Strength enabled" targets:<[player]>

# Gives the player Invisibility until death
spoints_shop_item_Invisibility:
    type: item
    material: ender_eye
    display name: <&color[#6065f7]>Invisibility!
    lore:
    - <&sp>
    - <&7>Costs: <&a>30 <&7>points
    - <&sp>
    - <&7><&o>Lasts until death
    flags:
        cost: 30
        script: spoints_shop_script_invisibility

spoints_shop_script_invisibility:
    type: task
    debug: false
    definitions: player
    script:
        - cast invisibility amplifier:0 d:999999 hide_particles <[player]>
        - narrate "<&color[#6065f7]>Invisibility enabled" targets:<[player]>

# Gives the player jump until death
spoints_shop_item_jump:
    type: item
    material: slime_ball
    display name: <&color[#60f7a4]>Jump boost!
    lore:
    - <&sp>
    - <&7>Costs: <&a>10 <&7>points
    - <&sp>
    - <&7><&o>Lasts until death
    flags:
        cost: 10
        script: spoints_shop_script_jump

spoints_shop_script_jump:
    type: task
    debug: false
    definitions: player
    script:
        - cast jump amplifier:0 d:999999 hide_particles <[player]>
        - narrate "<&color[#60f7a4]>Jump Boost enabled" targets:<[player]>

# Gives the player luck until death
spoints_shop_item_luck:
    type: item
    material: rabbit_foot
    display name: <&color[#48f73b]>Luck!
    lore:
    - <&sp>
    - <&7>Costs: <&a>5 <&7>points
    - <&sp>
    - <&7><&o>Lasts until death
    flags:
        cost: 5
        script: spoints_shop_script_luck

spoints_shop_script_luck:
    type: task
    debug: false
    definitions: player
    script:
        - cast luck amplifier:0 d:999999 hide_particles <[player]>
        - narrate "<&color[#48f73b]>Luck enabled" targets:<[player]>

# Gives the player regeneration until death
spoints_shop_item_regeneration:
    type: item
    material: honey_bottle
    display name: <&color[#cf5978]>Regeneration!
    lore:
    - <&sp>
    - <&7>Costs: <&a>100 <&7>points
    - <&sp>
    - <&7><&o>Lasts until death
    flags:
        cost: 100
        script: spoints_shop_script_regeneration

spoints_shop_script_regeneration:
    type: task
    debug: false
    definitions: player
    script:
        - cast regeneration amplifier:0 d:999999 hide_particles <[player]>
        - narrate "<&color[#cf5978]>Regeneration enabled" targets:<[player]>

# Gives the player speed until death
spoints_shop_item_speed:
    type: item
    material: sugar
    display name: <&color[#57c7d4]>Speed boost!
    lore:
    - <&sp>
    - <&7>Costs: <&a>25 <&7>points
    - <&sp>
    - <&7><&o>Lasts until death
    flags:
        cost: 25
        script: spoints_shop_script_speed

spoints_shop_script_speed:
    type: task
    debug: false
    definitions: player
    script:
        - cast speed amplifier:0 d:999999 hide_particles <[player]>
        - narrate "<&color[#57c7d4]>Speed boost enabled" targets:<[player]>

# Gives the player water_breathing until death
spoints_shop_item_water_breathing:
    type: item
    material: axolotl_bucket
    display name: <&color[#56fcec]>Water breathing!
    lore:
    - <&sp>
    - <&7>Costs: <&a>30 <&7>points
    - <&sp>
    - <&7><&o>Lasts until death
    flags:
        cost: 30
        script: spoints_shop_script_water_breathing

spoints_shop_script_water_breathing:
    type: task
    debug: false
    definitions: player
    script:
        - cast water_breathing amplifier:0 d:999999 hide_particles <[player]>
        - narrate "<&color[#56fcec]>Water breathing enabled" targets:<[player]>
