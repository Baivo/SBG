### Farming perks
perks_farm:
    type: data
    #  Green Thumb. Chance to double drops from crops.
    greenthumb:
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
            - Chance to double drops from crops.
            - Works for crops that grow on farmland.
            - Also works with cocoa!
    greenthumb_crops:
        - wheat
        - carrots
        - potato
        - beetroot
        - cocoa
        - melon_block
        - pumpkin

perks_farm_events:
    type: world
    debug: false
    events:
        on block drops item from breaking:
        - if !<player.has_flag[perks.farm.greenthumb]>:
            - stop
        - define chance <element[<script[perks_farm].data_key[greenthumb.<player.flag[perks.farm.greenthumb].if_null[1]>]>].mul[100]>
        - if !<util.random_chance[<[chance]>]>:
            - stop
        - if <player.item_in_hand.enchantment_types.contains[<enchantment[silk_touch]>]>:
            - stop
        - define drops <context.drop_entities.parse[item]>
        - if <script[perks_farm].data_key[greenthumb_crops]> contains <context.material.name>:
            - foreach <[drops]> as:item:
                - define drops:->:<item[<[item]>]>
        - drop <[drops]> <context.location.center>
        - determine cancelled passively
