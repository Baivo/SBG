# define perk levels
# fuel efficiency, cook speed, output multiplier(?)
smelt_perks:
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
        p1: 0.5
        p2: 0.45
        p3: 0.4
        p4: 0.35
        p5: 0.3
        p6: 0.25
        p7: 0.2
        p8: 0.15
        p9: 0.1
        p10: 0.05
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
        p1: 8
        p2: 10
        p3: 12
        p4: 14
        p5: 16
        p6: 18
        p7: 20
        p8: 25
        p9: 30
        p10: 40

furnace_perk_events:
    type: world
    debug: true
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
            - define lore:->:<&nl><&6>Perks<&co>
            - define lore:->:<&7>Efficiency<&co><&sp><&e><player.flag[perks.smelt.efficiency].if_null[0]>
            - define lore:->:<&7>Speed<&co><&sp><&e><player.flag[perks.smelt.speed].if_null[0]>
            - define item <context.item.with[lore=<[lore]>]>
            - define item <[item].with_flag[perks.smelt.speed:<script[smelt_perks].data_key[<player.flag[perks.smelt.speed].if_null[1]>]>]>
            - define item <[item].with_flag[perks.smelt.efficiency:<script[smelt_perks].data_key[<player.flag[perks.smelt.efficiency].if_null[1]>]>]>
            - determine <[item]>
        # replace this with a furnace item script that adds the perks to the item at the crafting player's perk level
