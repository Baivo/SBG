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
        0: 1
        1: 1.5
        2: 2
        3: 2.5
        4: 3
        5: 3.5
        6: 4
        7: 4.5
        8: 5
        9: 5.5
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

smelt_events:
    type: world
    debug: true
    events:
        after furnace burns item:
        - define fueltime <context.location.furnace_burn_duration.in_ticks>
        - define perk <context.location.flag[perks.efficiency].if_null[1]>
        - define newtime <duration[<[fueltime].div[<[perk]>].div[20]>]>
        - adjust <context.location> furnace_burn_duration:<[newtime]>
        on furnace starts smelting item:
        - define cooktime <context.total_cook_time.in_ticks>
        - define perk <context.location.flag[perks.cookspeed].if_null[1]>
        - define newtime <duration[<[cooktime].div[<[perk]>].div[20]>]>
        - determine <[newtime]>
