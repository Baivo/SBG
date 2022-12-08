# Perks

# This is the backend logic for the perks system. Players will spend Server Points earned through ProjectSP (https://github.com/Baivo/SBG/tree/main/ProjectSP) to unlock and progress perks.
# Perks cover all aspects of server gameplay, including custom content not found in the base game.
# Each perk has 10 base levels, with each player starting from level 1.
# Each perk will have an additional set of levels per perk above the base 10, but will be locked behind a requirement.

# Begin smelting perks.
# These two perks are related to smelting speed, and the fuel efficiency of furnace fuel items.
# The perks are assigned to a player, and will carry over to furnaces that the player crafts.
# Once crafted, a furnace will have the perks of the player who crafted it assigned to it permanently.
# Any player or automated crafting system can benefit from the perks applied to the furnace.
perks_smelt:
    type: data
    # Fuel efficiency. Higher levels provide longer burn duration for furnace fuel items
    efficiency:
        1: 1
        2: 0.95
        3: 0.9
        4: 0.85
        5: 0.8
        6: 0.75
        7: 0.7
        8: 0.65
        9: 0.6
        10: 0.55
        11: 0.5
        12: 0.45
        13: 0.4
        14: 0.35
        15: 0.3
        16: 0.25
        17: 0.2
        18: 0.15
        19: 0.1
        20: 0.05
        21: 0.05
        info:
            - Increases burn duration of furnace fuel items.
            - Applied to furnaces you craft.
            - Crafted furnace works for all players.
    # Smelt/cook speed. Higher levels provide faster processing time for smelting/cooking items.
    speed:
        1: 1
        2: 1.5
        3: 2
        4: 2.5
        5: 3
        6: 3.5
        7: 4
        8: 4.5
        9: 5
        10: 6
        11: 8
        12: 10
        13: 15
        14: 20
        15: 25
        16: 30
        17: 35
        18: 40
        19: 50
        20: 100
        21: 100
        info:
            - Increases cook/smelt speed.
            - Applied to furnaces you craft.
            - Crafted furnace works for all players.

perks_smelt_events:
    type: world
    debug: false
    events:
        after furnace burns item:
        - define fueltime <context.location.furnace_burn_duration.in_ticks>
        - define perk <context.location.flag[perks.smelt.speed].if_null[1]>
        - define newtime <duration[<[fueltime].div[<[perk]>].div[20]>]>
        - adjust <context.location> furnace_burn_duration:<[newtime]>
        on furnace starts smelting item:
        - define cooktime <context.total_cook_time.in_ticks>
        - define perk <context.location.flag[perks.smelt.speed].if_null[1]>
        - define newtime <duration[<[cooktime].div[<[perk]>].div[20]>]>
        - determine <[newtime]>
        on furnace recipe formed:
        - if <player.flag[perks.smelt.efficiency].exists> || <player.flag[perks.smelt.speed].exists>:
            - define lore <list[]>
            - define lore:->:<&6>Perks<&co>
            - define lore:->:<&7>Efficiency<&co><&sp><&e><player.flag[perks.smelt.efficiency].if_null[0]>
            - define lore:->:<&7><&o>Increases<&sp>the<&sp>burn<&sp>duration<&sp>of<&sp>fuel<&sp>items.
            - define lore:->:<&7>Speed<&co><&sp><&e><player.flag[perks.smelt.speed].if_null[0]>
            - define lore:->:<&7><&o>Increases<&sp>the<&sp>smelting<&sp>speed<&sp>of<&sp>items.
            - define lore:->:<&a>Crafted<&sp>by<&co><&sp><&e><player.nameplate>
            - define item <context.item.with[lore=<[lore]>]>
            - define item <[item].with_flag[perks.smelt.speed:<script[perks_smelt].data_key[speed.<player.flag[perks.smelt.speed].if_null[1]>]>]>
            - define item <[item].with_flag[perks.smelt.efficiency:<script[perks_smelt].data_key[efficiency.<player.flag[perks.smelt.efficiency].if_null[1]>]>]>
            - define item <[item].with_flag[perks.smelt.item:<[item]>]>
            - determine <[item]>
        on player places furnace:
        - if <context.item_in_hand.has_flag[perks.smelt]>:
            - flag <context.location> perks.smelt.speed:<context.item_in_hand.flag[perks.smelt.speed]>
            - flag <context.location> perks.smelt.efficiency:<context.item_in_hand.flag[perks.smelt.efficiency]>
            - flag <context.location> perks.smelt.item:<context.item_in_hand.flag[perks.smelt.item]>
        on player breaks furnace:
        - if <context.location.has_flag[perks.smelt]>:
            - define item <item[<context.location.flag[perks.smelt.item]>]>
            - define item <[item].with_flag[perks.smelt.item:<[item]>]>
            - flag <context.location> perks.smelt:!
            - define inventory <context.location.inventory.list_contents>
            - define drops <list>
            - define drops:->:<[item]>
            - if <[inventory].any>:
                - foreach <[inventory]> as:item:
                    - define drops:->:<[item]>
            - determine <[drops]>
# End smelting perks.
