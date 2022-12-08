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
    debug: false
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
