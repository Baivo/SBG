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
        11: 0.55
        12: 0.6
        13: 0.65
        14: 0.7
        15: 0.75
        16: 0.8
        17: 0.85
        18: 0.9
        19: 0.95
        20: 1
        21: 1
        info:
            - Chance to double drops from ore blocks.
            - Stacks with fortune!
            - Does not work with silk touch.
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
        11: 0.11
        12: 0.12
        13: 0.13
        14: 0.14
        15: 0.15
        16: 0.16
        17: 0.17
        18: 0.18
        19: 0.19
        20: 0.2
        21: 0.2
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
        11: 0.55
        12: 0.6
        13: 0.65
        14: 0.7
        15: 0.75
        16: 0.8
        17: 0.85
        18: 0.9
        19: 0.95
        20: 1

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
        on block drops item from breaking:
        - if !<player.has_flag[perks.mine.precision]>:
            - stop
        - if !<util.random_chance[<script[perks_mine_materials].data_key[<player.flag[perks.mine.precision]>]>]>:
            - stop
        - if <player.item_in_hand.enchantment_types.contains[<enchantment[silk_touch]>]>:
            - stop
        - define drops <context.drop_entities.parse[item]>
        - if <script[perks_mine_materials].data_key[precision.regular]> contains <context.material.name>:
            - foreach <[drops]> as:item:
                - define drops:->:<item[<[item]>]>
        - drop <[drops]> <context.location.center>
        - determine cancelled passively
        # # prospecting
        # # reliable
        # on player item takes damage:
        # - if <player.flag[perks.mine.reliable].exists>:
        #     - if <util.random_chance[<player.flag[]>]>
        #     - determine cancelled
        # # vein miner
        # on player damages block:
        # - if <player.flag[perks.mine.veinminer].exists>:
        #     - determine instabreak
