## Mining perks.

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
        2: 0.005
        3: 0.01
        4: 0.015
        5: 0.02
        6: 0.025
        7: 0.03
        8: 0.035
        9: 0.04
        10: 0.05
        11: 0.06
        12: 0.07
        13: 0.08
        14: 0.09
        15: 0.1
        16: 0.11
        17: 0.12
        18: 0.13
        19: 0.14
        20: 0.15
        21: 0.15
        info:
            - Chance to find ore drops in non-ore blocks
            - Stone, Deepslate, Netherrack etc.
            - Drops based on the block broken.
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
        21: 1
        info:
            - Reduces durability loss from mining.
            - Stacks with unbreaking!
            - Max level removes durability loss completely!
    blastmining:
        1: 1
        2: 2
        3: 2.2
        4: 2.4
        5: 2.6
        6: 2.8
        7: 3
        8: 3.2
        9: 3.4
        10: 4
        11: 4.5
        12: 5
        13: 5.5
        14: 6
        15: 6.5
        16: 7
        17: 7.5
        18: 8
        19: 8.5
        20: 9
        21: 9

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


perks_mine_precision_event:
    type: world
    debug: false
    events:
        on player breaks block:
        - if !<util.random_chance[<element[<script[perks_mine].data_key[precision.<player.flag[perks.mine.precision].if_null[1]>]>].mul[100]>]>:
            - stop
        - if <player.item_in_hand.enchantment_types.contains[<enchantment[silk_touch]>]>:
            - stop
        - define mat <context.material.name>
        - if !<[mat].is_in[<script[perks_mine_materials].data_key[precision.regular]>]> || <[mat].is_in[<script[perks_mine_materials].data_key[precision.deepslate]>]> || <[mat].is_in[<script[perks_mine_materials].data_key[precision.nether]>]>:
            - stop
        - define drops <context.location.drops[<player.item_in_hand>].first.if_null[<item[air]>]>
        - drop <[drops]> <context.location>

perks_mine_prospecting_event:
    type: world
    debug: false
    events:
        on player breaks block:
        - if !<util.random_chance[<script[perks_mine].data_key[prospecting.<player.flag[perks.mine.prospecting].if_null[1]>].mul[100]>]>:
            - stop
        - if <player.item_in_hand.enchantment_types.contains[<enchantment[silk_touch]>]>:
            - stop
        - define mat <context.material.name>
        - if <[mat].is_in[<script[perks_mine_materials].data_key[prospecting.regular]>]>:
            - define bns <script[perks_mine_materials].data_key[precision.regular].random>
        - if <[mat].is_in[<script[perks_mine_materials].data_key[prospecting.deepslate]>]>:
            - define bns <script[perks_mine_materials].data_key[precision.deepslate].random>
        - if <[mat].is_in[<script[perks_mine_materials].data_key[prospecting.nether]>]>:
            - define bns <script[perks_mine_materials].data_key[precision.nether].random>
        - if !<[bns].exists>:
            - stop
        - modifyblock <context.location> <[bns]>
        - playeffect at:<context.location.center> effect:block_crack special_data:<[bns]> offset:1.2,1.2,1.2 quantity:5
        - playsound sound:BLOCK_AMETHYST_CLUSTER_PLACE volume:0.7 pitch:1.0 at:<context.location.center>
        - playeffect at:<context.location.center> effect:block_crack special_data:<[bns]> offset:1.2,1.2,1.2 quantity:5

perks_mine_reliable_event:
    type: world
    events:
        on player *_pickaxe takes damage:
        - if !<util.random_chance[<script[perks_mine].data_key[reliable.<player.flag[perks.mine.reliable].if_null[1]>].mul[100]>]>:
            - stop
        - else:
            - determine cancelled
## perk menu item logic
# Mining Precision
Spoints_Perks_Menu_Item_MiningPrecision:
    type: item
    material: golden_pickaxe
    display name: <&gradient[from=#FBB800;to=#FDD800]>Mining - Precision
    lore:
    - <&gradient[from=#C7C5FC;to=#C5DFFC]>Click to open Level-Up menu
    mechanisms:
        hides: all
    flags:
        script: SPoints_Perks_Menu_MiningPrecision_Script
        cost: 100

SPoints_Perks_Menu_MiningPrecision_Script:
    type: task
    definitions: player
    script:
        - run Spoints_Perks_levelup_script def.cost:100 def.perk:perks.mine.precision def.player:<[player]> def.perkname:Mining<&sp>Precision

# Mining Prospecting
Spoints_Perks_Menu_Item_MiningProspecting:
    type: item
    material: iron_pickaxe
    display name: <&gradient[from=#FBB800;to=#FDD800]>Mining - Prospecting
    lore:
    - <&gradient[from=#C7C5FC;to=#C5DFFC]>Click to open Level-Up menu
    mechanisms:
        hides: all
    flags:
        script: SPoints_Perks_Menu_MiningProspecting_Script
        cost: 100

SPoints_Perks_Menu_MiningProspecting_Script:
    type: task
    definitions: player
    script:
        - run Spoints_Perks_levelup_script def.cost:100 def.perk:perks.mine.prospecting def.player:<[player]> def.perkname:Mining<&sp>Prospecting

# Mining Reliable
Spoints_Perks_Menu_Item_MiningReliable:
    type: item
    material: netherite_pickaxe
    display name: <&gradient[from=#FBB800;to=#FDD800]>Mining - Reliable
    lore:
    - <&gradient[from=#C7C5FC;to=#C5DFFC]>Click to open Level-Up menu
    mechanisms:
        hides: all
    flags:
        script: SPoints_Perks_Menu_MiningReliable_Script
        cost: 20

SPoints_Perks_Menu_MiningReliable_Script:
    type: task
    definitions: player
    script:
        - run Spoints_Perks_levelup_script def.cost:20 def.perk:perks.mine.reliable def.player:<[player]> def.perkname:Reliable<&sp>Pickaxes

## Generic ability
abilitycooldown:
    type: task
    definitions: player|ability|cooldown
    script:
        - if <[player].name> != Baivo:
            - stop
        - if <[player].has_flag[<[ability]>cooldown]>:
            - define cooldown <[player].flag_expiration[<[ability]>cooldown].duration_since[<util.time_now>]>
            - actionbar "<&c>You must wait <&e><[cooldown].formatted> <&c>before using <[ability]> again."
            - stop
        - define counter <[player].flag[<[ability]>cooldown].if_null[0]>
        - define counter:++
        - flag <[player]> <[ability]>:<[counter]>
        - if <[player].has_flag[<[ability]>progressbar]>:
            - define id <[player].flag[<[ability]>progressbar]>
            - bossbar update id:<[id]> color:yellow progress:<[counter].div[10]> style:solid
        - else:
            - flag <[player]> <[ability]>progressbar:<[ability]>_<[player].name>
            - bossbar create id:<[ability]>_<[player].name> title:<[ability]> progress:<[counter].div[10]> color:yellow style:solid
        - if <[counter]> >= 5:
            - flag <[player]> <[ability]>progressbar:!
            - bossbar remove id:<[ability]>_<[player].name>
            - flag <[player]> <[ability]>cooldown:<[cooldown]>
            - flag <[player]> <[ability]>:!
            - run <[ability]>_run def.player:<[player]>
abilityremovebar:
    type: world
    events:
        on delta time secondly:
        # blastmine
        - foreach <server.online_players> as:player:
            - if <[player].name> != Baivo:
                - foreach next
            - if <[player].flag[blastmine].if_null[0]> <= 0:
                - flag <[player]> blastmineprogressbar:!
                - bossbar remove id:blastmine_<[player].name>

### Blast mining
# Blast mining event
perks_mine_blastmining_event:
    type: world
    debug: true
    events:
        on player right clicks block with:*_pickaxe:
            - ratelimit <player> 1t
            - run abilitycooldown def.player:<player> def.ability:blastmine def.cooldown:3s

blastmine_run:
    type: task
    definitions: player
    script:
    - playsound sound:ENTITY_GENERIC_EXPLODE volume:1.0 pitch:1.0 at:<player.location>
    - define power <[player].flag[perks.mine.blastmining].if_null[1]>
    - define target <[player].eye_location.ray_trace[return=precise;raysize=2;entities:*;range=50;ignore=<[player]>]>
    - define targetlist <[target].find_blocks[!air].within[<[power]>]||null>
    - if <[targetlist].is_empty>:
        - playeffect at:<[player].location> effect:smoke quantity:3 offset:1
        - playsound <[player].location> sound:ENTITY_GENERIC_EXTINGUISH_FIRE
        - determine cancelled
    - else:
        - foreach <[targetlist]> as:targetblock:
            - spawn falling_block[fallingblock_type=<[targetblock].material>] <[targetblock].above[1]> save:block
            - adjust <[targetblock]> coreprotect_log_removal:[user=<[player].nameplate>;material=<[targetblock].material.name>]
            - modifyblock <[targetblock]> air
            - define block <entry[block].spawned_entity>
            - define material <[targetblock].material>
            - flag <[block]> emblock:<[player].nameplate>
            - define logtype placement
            - shoot <[block]> origin:<[block].location> destination:<[block].location.face[<[target]>].backward[5]>