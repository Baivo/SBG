# Perks
# Begin smelting perks.
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
        P1: 0.5
        P2: 0.45
        P3: 0.4
        P4: 0.35
        P5: 0.3
        P6: 0.25
        P7: 0.2
        P8: 0.15
        P9: 0.1
        P10: 0.05
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
        P1: 8
        P2: 10
        P3: 15
        P4: 20
        P5: 25
        P6: 30
        P7: 35
        P8: 40
        P9: 50
        P10: 100

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
            - flag <context.location> perks.smelt:!
            - determine <[item]>
# End smelting perks.
# Begin mining perks.
perks_mine:
    type: data
    # Precision. Higher levels increase chance to find additional materials from ore blocks.
    precision:
        1: 0
        2: 0.1
        3: 0.15
        4: 0.2
        5: 0.25
        6: 0.3
        7: 0.35
        8: 0.4
        9: 0.45
        10: 0.5
        P1: 0.55
        P2: 0.6
        P3: 0.65
        P4: 0.7
        P5: 0.75
        P6: 0.8
        P7: 0.85
        P8: 0.9
        P9: 0.95
        P10: 1
    # Prospecting. Higher levels increase chance to find additional materials from non-ore blocks.
    prospecting:
        1: 0
        2: 0.01
        3: 0.02
        4: 0.03
        5: 0.04
        6: 0.05
        7: 0.06
        8: 0.07
        9: 0.08
        10: 0.1
        P1: 0.11
        P2: 0.12
        P3: 0.13
        P4: 0.14
        P5: 0.15
        P6: 0.16
        P7: 0.17
        P8: 0.18
        P9: 0.19
        P10: 0.2
    # Vein Miner. Reach level five in both of the above perks to unlock this perk.
    vein_miner:
        0: 0
        1: 1
    # Reliable. Higher levels increase chance for mining tools to not take durability damage each time a block is mined.
    # Mining tools crafted by the player receive additional enchantments based on the level of this perk ??? <----- could be it's own perk for all tools
    reliable:
        1: 0
        2: 0.1
        3: 0.15
        4: 0.2
        5: 0.25
        6: 0.3
        7: 0.35
        8: 0.4
        9: 0.45
        10: 0.5
        P1: 0.55
        P2: 0.6
        P3: 0.65
        P4: 0.7
        P5: 0.75
        P6: 0.8
        P7: 0.85
        P8: 0.9
        P9: 0.95
        P10: 1

perks_mine_materials:
    type: data
    Precision:
        regular:
            - coal_ore
            - copper_ore
            - iron_ore
            - gold_ore
            - redstone_ore
            - lapis_ore
            - emerald_ore
            - diamond_ore
        deepslate:
            - deepslate_coal_ore
            - deepslate_copper_ore
            - deepslate_iron_ore
            - deepslate_gold_ore
            - deepslate_redstone_ore
            - deepslate_lapis_ore
            - deepslate_emerald_ore
            - deepslate_diamond_ore
        nether:
            - nether_gold_ore
            - nether_quartz_ore
            - ancient_debris
            - gilded_blackstone
    prospecting:
        regular:
            - stone
            - infested_stone
            - granite
            - diorite
            - andesite
            - calcite
            - dripstone_block
            - sandstone
        deepslate:
            - deepslate
            - infested_deepslate
            - tuff
        nether:
            - netherrack
            - basalt
            - blackstone
        end:
            - end_stone


perks_mine_events:
    type: world
    debug: true
    events:
        # precision
        on block drops item from breaking:
        # add a check to stop the queue from running if the player used a silk touch item
        - if <script[perks_mine_materials].data_key[regular]> contains <context.material>:
            - determine <context.drop_entities.parse[item].include[<context.drop_entities.parse[item]>]>
        # prospecting
        # reliable
        on player item takes damage:
        - if <player.flag[perks.mine.reliable].exists>:
            - if <util.random_chance[<player.flag[]>]>
            - determine cancelled
        # vein miner
        on player damages block:
        - if <player.flag[perks.mine.veinminer].exists>:
            - determine instabreak
