# Perk logic
perks_smelt:
    type: data
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
## perk menu item logic
# Smelt Speed
Spoints_Perks_Menu_Item_FurnaceSpeed:
    type: item
    material: furnace
    display name: <&gradient[from=#FBB800;to=#FDD800]>Furnace Speed
    lore:
    - <&gradient[from=#C7C5FC;to=#C5DFFC]>Click to open Level-Up menu
    flags:
        script: SPoints_Perks_Menu_FurnaceSpeed_Script

SPoints_Perks_Menu_FurnaceSpeed_Script:
    type: task
    definitions: player
    script:
        - run Spoints_Perks_levelup_script def.cost:100 def.perk:perks.smelt.speed def.player:<[player]> def.perkname:Furnace<&sp>Speed
# Smelt Fuel Efficiency
Spoints_Perks_Menu_Item_FurnaceFuelEfficiency:
    type: item
    material: furnace
    display name: <&gradient[from=#FBB800;to=#FDD800]>Furnace Fuel Efficiency
    lore:
    - <&gradient[from=#C7C5FC;to=#C5DFFC]>Click to open Level-Up menu
    flags:
        script: SPoints_Perks_Menu_FurnaceFuelEfficiency_Script

SPoints_Perks_Menu_FurnaceFuelEfficiency_Script:
    type: task
    definitions: player
    script:
        - run Spoints_Perks_levelup_script def.cost:50 def.perk:perks.smelt.efficiency def.player:<[player]> def.perkname:Furnace<&sp>Fuel<&sp>Saver
