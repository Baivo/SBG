chat_map:
    type: world
    debug: true
    events:
        on player steps on block:
        - ratelimit <player> 1t
        - if !<player.has_flag[Baivo]>:
            - stop
        - define location <player.location.relative[8,0,8]>
        - define materialGrid <map>
        - define colorMap <map>
        - repeat 16:
            - repeat 16:
                - define materialGrid <[materialGrid].with[<[location]>].as[<[location].material.name>]>
                - define location <[location].relative[-1,0,0]>
            - define location <[location].relative[16,0,-1]>
        - define i 0
        - foreach <[materialGrid]> key:<[pixel]> as:<[material]>:
            - define avgColor <script[color_map].data_key[<[material]>].if_null[0,0,0]>
            - define colorMap <[colorMap].with[<[i]>].as[<[avgColor]>]>
            - define i:++
        - define i 0
        - repeat 16:
            - define row <list>
            - repeat 16:
                - define row <[row].include[<&color[<[colorMap].get[<[i]>]>]>■]>
                - define i:++
            - announce to_flagged:Baivo <[row].unseparated>
color_map:
    type: data
    default: 0,0,0
    air: 0,0,0
    jack_o_lantern: 214,152,52
    composter_side: 112,70,31
    frosted_ice_0: 140,181,252
    red_terracotta: 143,61,46
    potatoes_stage0: 58,129,40
    beetroots_stage3: 93,91,30
    end_rod: 205,196,185
    lilac_top: 154,125,147
    orange_concrete: 224,97,0
    tripwire_hook: 142,133,118
    dead_brain_coral_block: 124,117,114
    slime_block: 0,0,2
    fire_coral: 166,37,46
    white_stained_glass_pane_top: 246,246,246
    soul_torch: 109,115,89
    loom_side: 145,101,72
    structure_block_data: 79,65,80
    loom_bottom: 76,60,36
    dried_kelp_bottom: 50,58,38
    red_tulip: 89,128,32
    gray_concrete_powder: 76,81,84
    brain_coral: 197,84,152
    crimson_nylium: 130,31,31
    sweet_berry_bush_stage2: 59,88,56
    potatoes_stage1: 68,131,42
    repeater: 160,157,156
    pink_wool: 237,141,172
    stripped_oak_log_top: 160,129,77
    lectern_front: 129,100,55
    redstone_ore: 133,107,107
    dropper_front: 122,121,121
    kelp_plant: 86,130,42
    brown_stained_glass_pane_top: 97,73,48
    respawn_anchor_side3: 47,30,66
    tnt_top: 142,62,53
    dead_horn_coral_fan: 134,125,121
    respawn_anchor_side1: 42,26,64
    command_block_side: 177,133,107
    soul_fire_0: 51,192,197
    red_nether_bricks: 69,7,9
    cartography_table_side2: 82,61,42
    barrel_bottom: 121,89,51
    bookshelf: 117,94,59
    cauldron_top: 73,72,74
    loom_front: 148,118,82
    acacia_log_top: 150,88,55
    dead_bush: 107,78,40
    crimson_trapdoor: 103,50,72
    bell_bottom: 188,148,42
    birch_planks: 192,175,121
    wheat_stage1: 0,0,0
    gray_terracotta: 57,42,35
    crimson_roots: 126,8,41
    redstone_dust_line1: 240,240,240
    light_gray_stained_glass: 153,153,153
    shroomlight: 240,146,70
    light_gray_stained_glass_pane_top: 147,147,147
    cactus_bottom: 143,170,85
    nether_portal: 87,10,191
    cyan_concrete: 21,119,136
    blast_furnace_front: 107,107,107
    bee_nest_front_honey: 194,151,75
    piston_top_sticky: 122,149,92
    magenta_concrete_powder: 192,83,184
    potatoes_stage2: 85,129,47
    light_gray_glazed_terracotta: 144,166,167
    iron_bars: 136,139,135
    mushroom_stem: 203,196,185
    basalt_side: 73,72,77
    red_concrete_powder: 168,54,50
    tube_coral_block: 49,87,206
    blue_stained_glass: 51,76,178
    honey_block_bottom: 241,146,17
    pumpkin_top: 198,118,24
    quartz_block_bottom: 236,230,223
    chorus_plant: 93,57,93
    stonecutter_saw: 222,222,222
    sweet_berry_bush_stage1: 47,94,57
    soul_campfire_fire: 80,204,208
    crimson_nylium_side: 107,26,26
    end_stone_bricks: 218,224,162
    stonecutter_side: 106,90,78
    repeating_command_block_back: 128,109,166
    bell_side: 252,229,96
    coal_ore: 116,116,116
    tall_seagrass_bottom: 45,117,4
    vine: 116,116,116
    cake_inner: 133,84,60
    poppy: 128,64,37
    black_shulker_box: 25,25,29
    cyan_concrete_powder: 36,147,157
    redstone_lamp: 95,54,30
    cake_side: 203,151,121
    jigsaw_side: 62,53,63
    brewing_stand: 123,101,81
    cactus_top: 85,127,43
    crafting_table_front: 129,105,70
    smoker_side: 102,91,75
    cyan_glazed_terracotta: 52,118,125
    sunflower_bottom: 56,135,30
    brain_coral_fan: 202,84,153
    red_sandstone: 186,99,29
    structure_block_save: 86,71,87
    red_sandstone_top: 181,97,31
    glass: 175,213,219
    soul_lantern: 71,99,114
    blackstone: 42,35,40
    torch: 138,113,63
    beacon: 117,220,215
    smithing_table_bottom: 64,28,23
    daylight_detector_side: 66,55,35
    cauldron_side: 74,73,74
    bubble_coral: 161,23,159
    dark_oak_leaves: 150,150,150
    wheat_stage3: 0,0,0
    smithing_table_side: 55,35,35
    acacia_door_top: 167,95,60
    cyan_shulker_box: 20,121,135
    destroy_stage_2: 97,97,97
    honey_block_top: 251,185,52
    warped_roots_pot: 20,136,123
    seagrass: 50,126,8
    oak_door_bottom: 138,108,62
    red_shulker_box: 140,31,30
    green_terracotta: 76,83,42
    lime_terracotta: 103,117,52
    diorite: 188,188,188
    observer_back: 71,69,69
    magenta_concrete: 169,48,159
    oak_planks: 162,130,78
    nether_wart_stage2: 0,0,1
    chiseled_sandstone: 216,202,155
    terracotta: 152,94,67
    prismarine_bricks: 99,171,158
    activator_rail: 115,87,74
    acacia_trapdoor: 156,87,51
    hopper_outside: 66,65,68
    polished_basalt_side: 88,88,91
    packed_ice: 141,180,250
    oak_leaves: 144,144,144
    magenta_stained_glass_pane_top: 171,73,208
    stripped_crimson_stem: 137,57,90
    debug: 133,148,152
    dead_tube_coral_fan: 128,122,118
    magenta_shulker_box: 173,54,163
    quartz_block_top: 235,229,222
    wither_rose: 41,44,23
    tripwire: 129,129,129,
    carved_pumpkin: 150,84,17
    jungle_door_bottom: 158,113,78
    yellow_glazed_terracotta: 234,192,88
    melon_side: 114,146,30
    item_frame: 116,67,42
    chiseled_stone_bricks: 119,118,119
    anvil_top: 72,72,72
    wheat_stage7: 166,151,73
    fletching_table_side: 191,167,129
    lectern_top: 173,137,83
    lapis_block: 30,67,140
    beetroots_stage1: 66,138,41
    red_mushroom_block: 200,46,45
    orange_wool: 240,118,19
    sandstone_top: 223,214,170
    mushroom_block_inside: 201,170,120
    stonecutter_top: 123,118,111
    birch_log: 216,215,210
    chiseled_polished_blackstone: 53,48,56
    beetroots_stage2: 69,130,39
    polished_basalt_top: 99,98,100
    brown_mushroom_block: 149,111,81
    grass_path_side: 142,105,69
    redstone_block: 0,0,3
    piston_top: 154,127,87
    dragon_egg: 12,9,15
    mossy_cobblestone: 110,118,94
    green_stained_glass_pane_top: 97,122,48
    red_wool: 160,39,34
    destroy_stage_7: 102,102,102
    flower_pot: 124,68,53
    chiseled_nether_bricks: 47,23,28
    observer_back_on: 76,68,68
    barrel_top: 134,100,58
    blue_concrete: 44,46,143
    barrel_top_open: 92,67,34
    netherrack: 97,38,38
    lantern: 106,91,83
    white_wool: 233,236,236
    polished_diorite: 192,193,194
    barrel_side: 107,81,50
    cyan_terracotta: 86,91,91
    yellow_stained_glass_pane_top: 221,221,48
    redstone_dust_dot: 240,240,240
    prismarine: 99,156,151
    kelp: 87,140,44
    structure_block: 88,74,90
    beehive_front_honey: 167,131,74
    warped_roots: 20,138,124
    black_concrete: 8,10,15
    bubble_coral_fan: 160,32,159
    chain_command_block_back: 130,157,145
    beehive_side: 157,126,75
    dead_fire_coral: 136,128,124
    pink_shulker_box: 230,121,157
    red_glazed_terracotta: 181,59,53
    potatoes_stage3: 84,135,47
    dark_oak_trapdoor: 75,49,23
    nether_wart_stage0: 0,0,0
    dark_oak_planks: 66,43,20
    cocoa_stage1: 146,110,56
    campfire_log: 79,74,67
    weeping_vines: 104,1,0
    tube_coral_fan: 50,91,208
    nether_gold_ore: 115,54,42
    orange_stained_glass: 216,127,51
    chain_command_block_front: 132,165,150
    smooth_stone_slab_side: 167,167,167
    destroy_stage_8: 101,101,101
    bamboo_singleleaf: 100,138,35
    grass_path_top: 148,121,65
    smoker_top: 84,82,80
    brown_terracotta: 77,51,35
    dead_brain_coral_fan: 132,125,121
    sandstone: 216,203,155
    grindstone_side: 139,139,139
    bee_nest_side: 196,150,77
    dried_kelp_side: 38,48,29
    oak_trapdoor: 124,99,56
    chipped_anvil_top: 72,72,72
    cyan_wool: 21,137,145
    composter_compost: 88,61,23
    crimson_planks: 101,48,70
    bamboo_stalk: 93,144,19
    command_block_front: 181,136,108
    light_blue_wool: 58,175,217
    fern: 124,124,124
    grindstone_round: 142,142,142
    green_concrete: 73,91,36
    bee_nest_front: 183,141,76
    cauldron_bottom: 40,40,44
    black_stained_glass_pane_top: 24,24,24
    structure_block_corner: 68,57,69
    crafting_table_top: 119,73,42
    sea_lantern: 172,199,190
    gray_glazed_terracotta: 83,90,93
    jungle_door_top: 163,119,84
    carrots_stage0: 44,110,39
    blue_orchid: 47,162,168
    chorus_flower_dead: 96,61,94
    composter_top: 152,98,51
    blue_concrete_powder: 70,73,166
    green_stained_glass: 102,127,51
    piston_side: 110,104,96
    observer_top: 98,98,98
    cobblestone: 127,127,127
    turtle_egg: 228,226,191
    spruce_leaves: 126,126,126
    pink_glazed_terracotta: 235,154,181
    lime_concrete: 94,168,24
    coal_block: 16,15,15
    orange_stained_glass_pane_top: 208,122,48
    wheat_stage6: 0,0,3
    lime_stained_glass: 127,204,25
    fire_1: 211,138,49
    warped_stem: 58,58,77
    light_gray_wool: 142,142,134
    honeycomb_block: 229,148,29
    sand: 219,207,163
    ladder: 124,96,54
    spruce_planks: 114,84,48
    acacia_leaves: 149,148,148
    lime_wool: 112,185,25
    dirt: 134,96,67
    cut_red_sandstone: 189,101,31
    light_gray_terracotta: 135,106,97
    furnace_side: 120,120,120
    mossy_stone_bricks: 115,121,105
    diamond_ore: 125,142,141
    crimson_door_bottom: 115,55,79
    cake_bottom: 133,62,32
    black_glazed_terracotta: 67,30,32
    glowstone: 171,131,84
    blackstone_top: 42,36,41
    respawn_anchor_side0: 39,23,62
    yellow_concrete_powder: 232,199,54
    sweet_berry_bush_stage3: 68,77,50
    sea_pickle: 90,97,39
    warped_planks: 43,104,99
    mycelium_side: 113,87,71
    blast_furnace_front_on: 115,110,105
    purpur_block: 169,125,169
    yellow_wool: 248,197,39
    observer_front: 103,103,103
    cut_sandstone: 217,206,159
    lily_pad: 133,133,133
    respawn_anchor_side4: 49,32,68
    green_wool: 84,109,27
    frosted_ice_2: 138,179,252
    activator_rail_on: 143,87,74
    warped_trapdoor: 47,119,111
    ice: 145,183,253
    daylight_detector_top: 130,116,94
    piston_bottom: 97,96,96
    yellow_stained_glass: 229,229,51
    soul_fire_1: 55,193,197
    sunflower_back: 54,127,34
    twisting_vines: 20,143,124
    cyan_stained_glass: 76,127,153
    nether_wart_stage1: 0,0,1
    jigsaw_bottom: 34,27,37
    snow: 249,254,254
    cartography_table_top: 104,87,67
    lilac_bottom: 137,124,126
    gray_stained_glass: 76,76,76
    destroy_stage_1: 98,98,98
    end_portal_frame_side: 150,162,122
    horn_coral_block: 216,199,66
    soul_campfire_log_lit: 69,106,104
    quartz_pillar: 235,230,224
    crimson_fungus: 141,44,29
    chiseled_quartz_block_top: 231,226,217
    bubble_coral_block: 165,26,162
    sponge: 195,192,74
    wheat_stage2: 0,0,0
    target_side: 229,176,168
    repeating_command_block_side: 128,110,170
    basalt_top: 80,81,86
    grass_block_snow: 169,150,133
    quartz_pillar_top: 235,229,222
    turtle_egg_very_cracked: 207,203,165
    light_blue_stained_glass: 102,153,216
    conduit: 159,139,113
    fire_0: 211,140,53
    bell_top: 253,235,110
    orange_concrete_powder: 227,131,31
    brown_mushroom: 153,116,92
    stripped_dark_oak_log_top: 65,44,22
    respawn_anchor_top: 76,23,150
    oak_sapling: 77,106,40
    gray_wool: 62,68,71
    carrots_stage2: 56,113,37
    orange_shulker_box: 234,106,8
    jungle_log_top: 149,109,70
    purple_glazed_terracotta: 109,48,152
    bamboo_large_leaves: 72,117,25
    cyan_stained_glass_pane_top: 73,122,147
    spawner: 36,46,62
    weeping_vines_plant: 132,16,12
    smooth_stone: 158,158,158
    magma: 142,63,31
    light_blue_glazed_terracotta: 94,164,208
    nether_wart_block: 114,2,2
    destroy_stage_4: 102,102,102
    furnace_front_on: 121,112,93
    dead_bubble_coral: 132,124,120
    rose_bush_top: 131,66,37
    note_block: 88,58,40
    cocoa_stage2: 156,94,43
    granite: 149,103,85
    jungle_log: 85,67,25
    rail: 125,111,88
    netherite_block: 66,61,63
    anvil: 68,68,68
    birch_sapling: 127,160,79
    fletching_table_front: 173,155,111
    pumpkin_stem: 0,0,0
    red_sand: 190,102,33
    beehive_end: 180,146,90
    iron_ore: 136,130,127
    campfire_fire: 219,158,58
    red_stained_glass: 153,51,51
    horn_coral: 209,186,62
    stone_bricks: 122,121,122
    daylight_detector_inverted_top: 106,109,112
    red_sandstone_bottom: 185,98,28
    gold_block: 246,208,61
    stone: 125,125,125
    light_gray_concrete_powder: 154,154,148
    blue_wool: 53,57,157
    respawn_anchor_top_off: 33,21,52
    repeater_on: 169,157,156
    warped_wart_block: 22,119,121
    stripped_acacia_log_top: 166,91,51
    purpur_pillar_top: 0,0,2
    acacia_planks: 168,90,50
    destroy_stage_6: 101,101,101
    dead_fire_coral_fan: 124,118,114
    purpur_pillar: 171,129,171
    brown_wool: 114,71,40
    debug2: 123,119,117
    blue_glazed_terracotta: 47,64,139
    glass_pane_top: 211,239,244
    smoker_front: 87,75,57
    crafting_table_side: 128,102,63
    dandelion: 147,172,43
    end_portal_frame_eye: 35,70,62
    polished_andesite: 132,134,133
    comparator_on: 175,161,159
    sandstone_bottom: 215,202,154
    composter_ready: 116,93,56
    tube_coral: 47,83,197
    carrots_stage3: 81,123,37
    nether_bricks: 0,0,3
    sunflower_top: 49,129,27
    powered_rail_on: 154,109,74
    dispenser_front_vertical: 98,97,97
    dropper_front_vertical: 97,96,96
    detector_rail_on: 137,103,89
    spruce_sapling: 44,60,36
    enchanting_table_bottom: 15,10,24
    white_terracotta: 209,178,161
    chorus_flower: 151,120,151
    black_terracotta: 37,22,16
    piston_inner: 97,97,97
    bone_block_side: 229,225,207
    lever: 111,93,67
    grass_block_side_overlay: 154,154,154
    warped_door_top: 44,126,120
    pink_concrete_powder: 228,153,181
    pink_stained_glass: 242,127,165
    light_blue_concrete_powder: 74,180,213
    stripped_jungle_log: 171,132,84
    jukebox_side: 0,0,4
    bedrock: 85,85,85
    oak_log: 109,85,50
    magenta_terracotta: 149,88,108
    red_mushroom: 216,75,67
    light_blue_shulker_box: 49,163,212
    smoker_bottom: 107,105,103
    stripped_dark_oak_log: 96,76,49
    pink_stained_glass_pane_top: 233,122,159,
    light_blue_concrete: 35,137,198
    crimson_stem_top: 107,51,74
    farmland: 143,102,70
    bamboo_small_leaves: 71,113,26
    hay_block_top: 165,139,12
    oxeye_daisy: 179,202,143
    pink_concrete: 213,101,142
    dead_tube_coral_block: 130,123,119
    sweet_berry_bush_stage0: 42,89,56
    spruce_log_top: 108,80,46
    iron_trapdoor: 0,0,3
    green_glazed_terracotta: 117,142,67
    blast_furnace_top: 80,80,81
    fire_coral_block: 163,35,46
    honey_block_side: 250,188,57
    redstone_lamp_on: 142,101,60
    emerald_block: 42,203,87
    birch_door_bottom: 208,194,144
    soul_sand: 81,62,50
    scaffolding_bottom: 208,181,100
    horn_coral_fan: 205,183,61
    attached_pumpkin_stem: 139,139,139
    red_stained_glass_pane_top: 147,48,48
    tall_grass_top: 151,149,151
    lime_glazed_terracotta: 162,197,55
    frosted_ice_1: 139,180,252,
    white_concrete: 207,213,214
    beehive_front: 159,128,77
    warped_nylium: 43,114,101
    light_gray_concrete: 125,125,115
    melon_top: 111,144,30
    quartz_block_side: 235,229,222
    birch_leaves: 130,129,130
    stripped_birch_log: 196,176,118
    enchanting_table_top: 128,75,85
    destroy_stage_0: 108,108,108
    redstone_dust_line0: 240,240,240
    comparator: 166,161,159
    tnt_side: 182,88,84
    acacia_sapling: 118,117,23
    dark_oak_door_bottom: 73,49,23
    turtle_egg_slightly_cracked: 218,214,177
    pink_tulip: 99,157,78
    light_blue_stained_glass_pane_top: 97,147,208
    magenta_glazed_terracotta: 208,100,191
    warped_door_bottom: 43,118,112
    cracked_polished_blackstone_bricks: 43,37,43
    respawn_anchor_side2: 44,28,65
    soul_soil: 75,57,46
    dead_brain_coral: 133,125,120
    gray_stained_glass_pane_top: 73,73,73
    brown_stained_glass: 102,76,51
    lectern_base: 163,122,75
    composter_bottom: 116,71,32
    black_wool: 20,21,25
    grindstone_pivot: 73,45,21
    melon_stem: 153,153,153
    furnace_front: 91,91,91
    dead_fire_coral_block: 131,123,119
    birch_door_top: 220,209,176
    stonecutter_bottom: 118,117,118
    end_stone: 219,222,158
    coarse_dirt: 119,85,59
    warped_nylium_side: 72,61,59
    hay_block_side: 166,136,38
    dark_oak_sapling: 61,90,30
    target_top: 226,170,157
    brown_shulker_box: 106,66,35
    chiseled_quartz_block: 231,226,218
    grass_block_side: 126,107,65
    clay: 160,166,179
    black_concrete_powder: 25,26,31
    stripped_oak_log: 177,144,86
    iron_door_top: 193,192,192
    destroy_stage_9: 101,101,101
    polished_blackstone: 53,48,56
    gray_shulker_box: 55,58,62
    cracked_stone_bricks: 118,117,118
    purple_stained_glass_pane_top: 122,61,171
    emerald_ore: 117,136,124
    lectern_sides: 149,117,67
    lava_still: 212,90,18
    beetroots_stage0: 65,137,41
    campfire_log_lit: 110,88,54
    frosted_ice_3: 135,178,252
    cartography_table_side3: 69,43,20
    white_glazed_terracotta: 188,212,202
    azure_bluet: 169,204,127
    white_concrete_powder: 225,227,227
    lapis_ore: 99,110,132
    blue_shulker_box: 43,45,140
    acacia_door_bottom: 162,91,57
    respawn_anchor_bottom: 32,10,60
    yellow_concrete: 240,175,21
    warped_fungus: 74,109,87
    nether_sprouts: 19,151,133
    obsidian: 15,10,24
    polished_blackstone_bricks: 46,41,48
    quartz_bricks: 234,229,221
    orange_terracotta: 161,83,37
    birch_log_top: 193,179,135
    lime_shulker_box: 99,172,23
    peony_top: 129,126,139
    spruce_door_top: 106,80,48
    furnace_top: 110,109,109
    jigsaw_top: 80,69,81
    podzol_top: 91,63,24
    rose_bush_bottom: 97,83,37
    tnt_bottom: 166,66,53
    dead_bubble_coral_fan: 140,134,130
    command_block_back: 173,131,106
    fletching_table_top: 197,180,133
    brain_coral_block: 207,91,159
    repeating_command_block_front: 129,111,176
    wet_sponge: 171,181,70
    dead_tube_coral: 118,111,107
    bricks: 150,97,83
    carrots_stage1: 52,120,40
    acacia_log: 103,96,86
    end_portal_frame_top: 91,120,97
    tall_seagrass_top: 59,139,14
    dead_horn_coral_block: 133,126,122
    orange_tulip: 93,142,30
    lily_of_the_valley: 123,174,95
    wheat_stage0: 0,0,0
    damaged_anvil_top: 72,72,72
    purple_concrete_powder: 131,55,177
    dead_horn_coral: 142,135,129
    pink_terracotta: 161,78,78
    peony_bottom: 86,101,93
    redstone_torch_off: 101,69,43
    dark_oak_log_top: 64,42,21
    hopper_top: 75,74,75
    orange_glazed_terracotta: 154,147,91
    stripped_spruce_log_top: 105,80,46
    black_stained_glass: 25,25,25
    ancient_debris_top: 94,66,58
    yellow_shulker_box: 248,188,29
    repeating_command_block_conditional: 127,109,171
    jungle_planks: 160,115,80
    green_concrete_powder: 97,119,44
    stripped_warped_stem: 57,150,147
    smithing_table_front: 56,37,38
    redstone_torch: 171,79,44
    blue_terracotta: 74,59,91
    grass: 145,145,145
    birch_trapdoor: 207,194,157
    yellow_terracotta: 186,133,35
    gravel: 131,127,126
    enchanting_table_side: 49,46,57
    bee_nest_top: 202,160,74
    brown_concrete: 96,59,31
    allium: 158,137,183
    magenta_stained_glass: 178,76,216,
    blue_stained_glass_pane_top: 48,73,171
    stripped_acacia_log: 174,92,59
    purple_shulker_box: 103,32,156
    brown_glazed_terracotta: 119,106,85
    destroy_stage_5: 102,102,102
    pumpkin_side: 195,114,24
    gilded_blackstone: 56,43,38
    sunflower_front: 246,196,54
    command_block_conditional: 178,133,105
    cornflower: 79,121,146
    mycelium_top: 0,0,4
    stripped_warped_stem_top: 0,0,2
    destroy_stage_3: 101,101,101
    polished_granite: 154,106,89
    white_tulip: 93,164,71
    hopper_inside: 49,49,53
    purple_concrete: 100,31,156
    smithing_table_top: 57,58,70
    crying_obsidian: 32,10,60
    farmland_moist: 81,44,15
    scaffolding_side: 206,178,98
    dark_prismarine: 51,91,75
    loom_top: 142,119,91
    light_gray_shulker_box: 124,124,115
    lava_flow: 207,91,19
    white_shulker_box: 215,220,221
    fire_coral_fan: 158,34,45
    bone_block_top: 209,206,179
    crimson_stem: 92,25,29
    stripped_crimson_stem_top: 0,0,2
    chiseled_red_sandstone: 183,96,27
    jungle_leaves: 156,154,143
    stripped_spruce_log: 115,89,52
    ancient_debris_side: 95,63,55
    stripped_birch_log_top: 191,171,116
    stripped_jungle_log_top: 165,122,81
    sugar_cane: 148,192,101
    spruce_log: 58,37,16
    warped_stem_top: 57,103,103
    gold_ore: 143,140,125
    crimson_roots_pot: 127,8,41
    powered_rail: 137,109,74
    bamboo_stage0: 92,89,35
    cracked_nether_bricks: 40,20,23
    brown_concrete_powder: 125,84,53
    dark_oak_log: 60,46,26
    smoker_front_on: 118,97,66
    lodestone_side: 119,119,123
    bee_nest_bottom: 160,127,87
    lime_concrete_powder: 125,189,41
    grass_block_top: 147,147,147
    twisting_vines_plant: 20,135,122
    lodestone_top: 147,149,152
    wheat_stage4: 0,0,1
    red_concrete: 142,32,32
    blue_ice: 116,167,253
    cocoa_stage0: 133,135,62
    observer_side: 70,68,68
    magenta_wool: 189,68,179
    andesite: 136,136,136
    oak_log_top: 151,121,73
    oak_door_top: 139,110,65
    tall_grass_bottom: 128,128,128
    detector_rail: 123,104,90
    lime_stained_glass_pane_top: 122,196,24
    shulker_box: 0,0,12
    cobweb: 228,233,234
    nether_quartz_ore: 117,65,62
    chain: 51,57,74
    brewing_stand_base: 116,105,105
    spruce_door_bottom: 105,80,48
    purple_terracotta: 118,70,86
    water_flow: 168,168,168
    wheat_stage5: 0,0,2
    iron_door_bottom: 195,194,194
    white_stained_glass: 255,255,255,
    light_blue_terracotta: 113,108,137
    cartography_table_side1: 72,50,34
    dried_kelp_top: 50,58,38
    iron_block: 220,220,220
    chain_command_block_conditional: 129,161,147
    water_still: 177,177,177
    chain_command_block_side: 131,161,147
    rail_corner: 130,115,89
    scaffolding_top: 174,134,80
    structure_block_load: 69,57,70
    attached_melon_stem: 0,0,0
    cake_top: 248,222,214
    diamond_block: 98,237,228
    jigsaw_lock: 45,38,47
    spruce_trapdoor: 103,79,47
    purple_wool: 121,42,172
    dead_bubble_coral_block: 131,123,119
    podzol_side: 122,87,57
    jungle_sapling: 47,81,16
    green_shulker_box: 79,100,31
    cactus_side: 88,130,45
    large_fern_bottom: 131,131,131
    water_overlay: 165,165,165
    crimson_door_top: 114,54,79
    gray_concrete: 54,57,61
    jungle_trapdoor: 152,110,77
    dark_oak_door_top: 76,51,25
    dispenser_front: 0,0,6
    jukebox_top: 93,64,47
    purple_stained_glass: 127,63,178
    blast_furnace_side: 107,107,107
    large_fern_top: 0,0,1
    cauldron_inner: 49,49,53
