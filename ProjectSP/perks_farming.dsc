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
        21: 1
        info:
            - Reduces durability loss for farm tools.
            - Works with Hoes, Shears.
            - Max level removes durability loss completely!

perks_farm_events:
    type: world
    debug: false
    events:
        on player breaks block:
        - if !<player.has_flag[perks.farm.greenthumb]>:
            - stop
        - if !<util.random_chance[<element[<script[perks_farm].data_key[greenthumb.<player.flag[perks.farm.greenthumb].if_null[1]>]>].mul[100]>]>:
            - stop
        - if <player.item_in_hand.enchantment_types.contains[<enchantment[silk_touch]>]>:
            - stop
        - if !<context.material.name.is_in[<script[perks_farm].data_key[greenthumb_crops]>]>:
            - stop
        - define drops <context.location.drops[<player.item_in_hand>].first.if_null[<item[air]>]>
        - drop <[drops]> <context.location>

perks_farm_reliable_hoeevent:
    type: world
    events:
        on player *_hoe takes damage:
        - if !<util.random_chance[<script[perks_farm].data_key[reliable.<player.flag[perks.farm.reliable].if_null[1]>].mul[100]>]>:
            - stop
        - else:
            - determine cancelled
perks_farm_reliable_shearevent:
    type: world
    events:
        on player shears takes damage:
        - if !<util.random_chance[<script[perks_farm].data_key[reliable.<player.flag[perks.farm.reliable].if_null[1]>].mul[100]>]>:
            - stop
        - else:
            - determine cancelled
## perk menu item logic
# Green Thumb
Spoints_Perks_Menu_Item_GreenThumb:
    type: item
    material: golden_hoe
    display name: <&gradient[from=#FBB800;to=#FDD800]>Farming - Green Thumb
    lore:
    - <&gradient[from=#C7C5FC;to=#C5DFFC]>Click to open Level-Up menu
    mechanisms:
        hides: all
    flags:
        script: SPoints_Perks_Menu_GreenThumb_Script
        cost: 50

SPoints_Perks_Menu_GreenThumb_Script:
    type: task
    definitions: player
    script:
        - run Spoints_Perks_levelup_script def.cost:50 def.perk:perks.farm.greenthumb def.player:<[player]> def.perkname:Green<&sp>Thumb
# Farming Reliable
Spoints_Perks_Menu_Item_FarmingReliable:
    type: item
    material: netherite_hoe
    display name: <&gradient[from=#FBB800;to=#FDD800]>Farming - Reliable
    lore:
    - <&gradient[from=#C7C5FC;to=#C5DFFC]>Click to open Level-Up menu
    mechanisms:
        hides: all
    flags:
        script: SPoints_Perks_Menu_FarmingReliable_Script
        cost: 20

SPoints_Perks_Menu_FarmingReliable_Script:
    type: task
    definitions: player
    script:
        - run Spoints_Perks_levelup_script def.cost:20 def.perk:perks.farm.reliable def.player:<[player]> def.perkname:Reliable<&sp>Farm<&sp>Tools