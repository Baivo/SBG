# define perk levels
# fuel efficiency, cook speed, output multiplier
smelt_perks:
    type: data
# Reduces fuel cost of smelting. Will need to adjust the fuel cost of the furnace to account for this.
    efficiency:
        0: 1
        1: 0.95
        2: 0.9
        3: 0.85
        4: 0.8
        5: 0.75
        6: 0.7
        7: 0.65
        8: 0.6
        9: 0.55
        10: 0.5
        p1: 0.45
        p2: 0.4
        p3: 0.35
        p4: 0.3
        p5: 0.25
        p6: 0.2
        p7: 0.15
        p8: 0.1
        p9: 0.05

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
