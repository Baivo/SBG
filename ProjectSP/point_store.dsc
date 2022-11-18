# Author: Baivo
# Version 1.1
#
# Changelog:
# 1.1
# Fixed a bug that just deadset deleted the player's inventory, don't even get me started lmao
# Was a stupid oversight and i've made sure it can't happen again. 
# Blame denizen's default inventory command behaviour forcing the player inventory as a default, even if a (broken) alternative was there, instead of my poor code review.

# This is probably getting overhauled again now that I have Mergu compensating for my laziness


spoints_shop_transact:
    type: task
    debug: true
    definitions: player|cost|script
    script:
    - if <[player].flag[SP_Balance]> >= <[cost]>:
        - actionbar "<&c><[cost]><&e> points subtracted from your balance!" targets:<[player]>
        - flag <[player]> SP_Balance:-:<[cost]>
        - run <[script]> def.player:<[player]>
    - else:
        - narrate "<&c>Not enough points!" targets:<[player]>
        - inventory close d:<inventory[Spoints_Shop_<[player].name>]>

spoints_shop_update:
    type: task
    definitions: player
    script:
        - define playername <[player].name>
        - define inv <inventory[Spoints_Shop_<[playername]>]>
        - flag server Spoints.<[playername]>:<inventory[Spoints_Shop]>
        - note <inventory[<server.flag[Spoints.<[playername]>]>]> as:Spoints_Shop_<[playername]>
        - adjust <[inv]> "title:<&a>Point Shop <&7>| <&a>Balance: <&3><[player].flag[SP_balance]>"
        - inventory update d:<[inv]>

spoints_shopcmd:
    type: command
    name: redeem
    debug: true
    description: Open the Point Shop
    usage: /redeem
    script:
    - define playername <player.name>
    - run spoints_shop_update def.inv:<inventory[Spoints_Shop_<[playername]>]> def.player:<player>
    - inventory open d:Spoints_Shop_<[playername]>

Spoints_Shop:
    type: inventory
    inventory: chest
    title: <&a>Point Shop
    size: 9
    gui: true
    slots:
    - [spoints_shop_nightvision_item] [spoints_shop_fireresistance_item] [] [] [] [] [] [spoints_shop_day_item] [spoints_shop_health_item]
