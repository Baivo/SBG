# define perk levels
# fuel efficiency, cook speed, output multiplier
smelt_perks:
    type: data
# Reduces fuel cost of smelting. Will need to adjust the fuel cost of the furnace to account for this.
# The fuel cost reduction per level represents the percentage of fuel cost reduction.
# When adding fuel to a furnace, the burn time for the furnace is set to the burn time of the fuel item in ticks.
# This means simply multipying the burn time in ticks based on the fuel item by the perk level percentage would not work, as this would decrease the burn time, resulting in increasing fuel cost per level.
# Instead, the burn time in ticks needs to be divided by the fuel cost reduction percentage, unless the perk level reaches P10, in which case the burn time in ticks is set to 0 and the furnace is set to ignore fuel and always burn.
    efficiency:
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
        p10: 0.0

smelt_events:
    type: world
    debug: true
    events:
        after furnace burns item:
        - define fueltime <duration[<context.location.furnace_burn_duration>].in_ticks>
        - announce to_flagged:Baivo "<&c>Fuel time: <&e><[fueltime]>"

        - define perk <context.location.flag[perks.efficiency].if_null[1]>
        - announce to_flagged:Baivo "<&d>Perk: <&e><[perk]>"

        - define newtime <[fueltime].div[<[perk]>].div[20]>
        - announce to_flagged:Baivo "<&b>New fuel time: <&e><[newtime]>"

        - adjust <context.location> furnace_burn_duration:<[newtime]>
        on furnace starts smelting item:
        - define cooktime <context.total_cook_time.in_ticks.div[20]>
        - announce to_flagged:Baivo "<&c>Cook time: <&e><[cooktime]>"

        - define perk <context.location.flag[perks.cookspeed].if_null[1]>
        - announce to_flagged:Baivo "<&d>Perk: <&e><[perk]>"

        - define newtime <[cooktime].div[<[perk]>].div[20]>
        - announce to_flagged:Baivo "<&b>New cook time: <&e><[newtime]>"

        - determine <[newtime]>
