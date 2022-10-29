netblock_function_note_clear:
    type: task
    debug: false
    definitions: player
    script:
    - flag <[player]> note:!
    # Use this to clear a player's note flag
    # Note flags are provided by default, and prevent a player from rapid firing a note sound
    # Placing note clear connections around a note sound connection, say, right above a note connection...
    # Will allow a player to play the same note again so long as their feet location leaves the one block space of the note connection
    # See the piano at TinkCorp Store in market for an example, netblocks are behind the tv at the back.

note_data:
    type: data
    pitches:
        # F#3
        0_FSharp: 0.5

        # G3
        1_G: 0.529732

        # G#3
        2_GSharp: 0.561231

        # A3
        3_A: 0.594604

        # A#3
        4_ASharp: 0.629961

        # B3
        5_B: 0.667420

        # C4
        6_C: 0.707107

        # C#4
        7_CSharp: 0.749154

        # D4
        8_D: 0.793701

        # D#4
        9_DSharp: 0.840896

        # E4
        10_E: 0.890899

        # F4
        11_F: 0.943874

        # F#4
        12_FSharp: 1.0

        # G4
        13_G: 1.059463

        # G#4
        14_GSharp: 1.122462

        # A4
        15_A: 1.189207

        # A#4
        16_ASharp: 1.259921

        # B4
        17_B: 1.334840

        # C5
        18_C: 1.414214

        # C#5
        19_CSharp: 1.498307

        # D5
        20_D: 1.587401

        # D#5
        21_DSharp: 1.681793

        # E5
        22_E: 1.781797

        # F5
        23_F: 1.887749

        # F#5
        24_FSharp: 2.0

    colours:
        0_FSharp: 0
        1_G: 0.042
        2_GSharp: 0.083
        3_A: 0.125
        4_ASharp: 0.167
        5_B: 0.208
        6_C: 0.250
        7_CSharp: 0.292
        8_D: 0.333
        9_DSharp: 0.375
        10_E: 0.417
        11_F: 0.458
        12_FSharp: 0.500
        13_G: 0.542
        14_GSharp: 0.583
        15_A: 0.625
        16_ASharp: 0.667
        17_B: 0.708
        18_C: 0.750
        19_CSharp: 0.792
        20_D: 0.833
        21_DSharp: 0.875
        22_E: 0.917
        23_F: 0.958
        24_FSharp: 1.000

nbf_note_proc:
    type: task
    definitions: player|note|instrument
    script:
    - if <[player].flag[note]> != <[note]>:
        - flag <[player]> note:<[note]>
        - playsound <[player].location> sound:block_note_block_<[instrument]> pitch:<script[note_data].data_key[pitches.<[note]>]>
        - playeffect <[player].location> effect:note data:<script[note_data].data_key[colours.<[note]>]>

## Pling ##
nbf_note_pling_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:pling

nbf_note_pling_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:pling

nbf_note_pling_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:pling

nbf_note_pling_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:pling

nbf_note_pling_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:pling

nbf_note_pling_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:pling

nbf_note_pling_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:pling

nbf_note_pling_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:pling

nbf_note_pling_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:pling

nbf_note_pling_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:pling

nbf_note_pling_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:pling

nbf_note_pling_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:pling

nbf_note_pling_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:pling

nbf_note_pling_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:pling

nbf_note_pling_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:pling

nbf_note_pling_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:pling

nbf_note_pling_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:pling

nbf_note_pling_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:pling

nbf_note_pling_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:pling

nbf_note_pling_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:pling

nbf_note_pling_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:pling

nbf_note_pling_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:pling

nbf_note_pling_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:pling

nbf_note_pling_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:pling

nbf_note_pling_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:pling

## Bass ##
nbf_note_bass_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:bass

nbf_note_bass_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:bass

nbf_note_bass_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:bass

nbf_note_bass_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:bass

nbf_note_bass_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:bass

nbf_note_bass_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:bass

nbf_note_bass_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:bass

nbf_note_bass_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:bass

nbf_note_bass_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:bass

nbf_note_bass_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:bass

nbf_note_bass_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:bass

nbf_note_bass_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:bass

nbf_note_bass_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:bass

nbf_note_bass_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:bass

nbf_note_bass_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:bass

nbf_note_bass_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:bass

nbf_note_bass_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:bass

nbf_note_bass_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:bass

nbf_note_bass_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:bass

nbf_note_bass_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:bass

nbf_note_bass_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:bass

nbf_note_bass_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:bass

nbf_note_bass_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:bass

nbf_note_bass_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:bass

nbf_note_bass_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:bass

## Snare ##
nbf_note_snare_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:snare

nbf_note_snare_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:snare

nbf_note_snare_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:snare

nbf_note_snare_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:snare

nbf_note_snare_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:snare

nbf_note_snare_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:snare

nbf_note_snare_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:snare

nbf_note_snare_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:snare

nbf_note_snare_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:snare

nbf_note_snare_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:snare

nbf_note_snare_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:snare

nbf_note_snare_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:snare

nbf_note_snare_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:snare

nbf_note_snare_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:snare

nbf_note_snare_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:snare

nbf_note_snare_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:snare

nbf_note_snare_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:snare

nbf_note_snare_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:snare

nbf_note_snare_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:snare

nbf_note_snare_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:snare

nbf_note_snare_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:snare

nbf_note_snare_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:snare

nbf_note_snare_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:snare

nbf_note_snare_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:snare

nbf_note_snare_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:snare

## hat ##
nbf_note_hat_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:hat

nbf_note_hat_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:hat

nbf_note_hat_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:hat

nbf_note_hat_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:hat

nbf_note_hat_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:hat

nbf_note_hat_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:hat

nbf_note_hat_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:hat

nbf_note_hat_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:hat

nbf_note_hat_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:hat

nbf_note_hat_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:hat

nbf_note_hat_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:hat

nbf_note_hat_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:hat

nbf_note_hat_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:hat

nbf_note_hat_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:hat

nbf_note_hat_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:hat

nbf_note_hat_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:hat

nbf_note_hat_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:hat

nbf_note_hat_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:hat

nbf_note_hat_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:hat

nbf_note_hat_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:hat

nbf_note_hat_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:hat

nbf_note_hat_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:hat

nbf_note_hat_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:hat

nbf_note_hat_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:hat

nbf_note_hat_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:hat

## bd ##
nbf_note_bd_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:bd

nbf_note_bd_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:bd

nbf_note_bd_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:bd

nbf_note_bd_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:bd

nbf_note_bd_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:bd

nbf_note_bd_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:bd

nbf_note_bd_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:bd

nbf_note_bd_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:bd

nbf_note_bd_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:bd

nbf_note_bd_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:bd

nbf_note_bd_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:bd

nbf_note_bd_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:bd

nbf_note_bd_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:bd

nbf_note_bd_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:bd

nbf_note_bd_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:bd

nbf_note_bd_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:bd

nbf_note_bd_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:bd

nbf_note_bd_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:bd

nbf_note_bd_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:bd

nbf_note_bd_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:bd

nbf_note_bd_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:bd

nbf_note_bd_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:bd

nbf_note_bd_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:bd

nbf_note_bd_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:bd

nbf_note_bd_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:bd

## bell ##
nbf_note_bell_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:bell

nbf_note_bell_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:bell

nbf_note_bell_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:bell

nbf_note_bell_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:bell

nbf_note_bell_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:bell

nbf_note_bell_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:bell

nbf_note_bell_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:bell

nbf_note_bell_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:bell

nbf_note_bell_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:bell

nbf_note_bell_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:bell

nbf_note_bell_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:bell

nbf_note_bell_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:bell

nbf_note_bell_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:bell

nbf_note_bell_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:bell

nbf_note_bell_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:bell

nbf_note_bell_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:bell

nbf_note_bell_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:bell

nbf_note_bell_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:bell

nbf_note_bell_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:bell

nbf_note_bell_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:bell

nbf_note_bell_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:bell

nbf_note_bell_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:bell

nbf_note_bell_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:bell

nbf_note_bell_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:bell

nbf_note_bell_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:bell

## flute ##
nbf_note_flute_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:flute

nbf_note_flute_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:flute

nbf_note_flute_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:flute

nbf_note_flute_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:flute

nbf_note_flute_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:flute

nbf_note_flute_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:flute

nbf_note_flute_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:flute

nbf_note_flute_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:flute

nbf_note_flute_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:flute

nbf_note_flute_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:flute

nbf_note_flute_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:flute

nbf_note_flute_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:flute

nbf_note_flute_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:flute

nbf_note_flute_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:flute

nbf_note_flute_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:flute

nbf_note_flute_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:flute

nbf_note_flute_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:flute

nbf_note_flute_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:flute

nbf_note_flute_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:flute

nbf_note_flute_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:flute

nbf_note_flute_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:flute

nbf_note_flute_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:flute

nbf_note_flute_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:flute

nbf_note_flute_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:flute

nbf_note_flute_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:flute

## chime ##
nbf_note_chime_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:chime

nbf_note_chime_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:chime

nbf_note_chime_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:chime

nbf_note_chime_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:chime

nbf_note_chime_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:chime

nbf_note_chime_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:chime

nbf_note_chime_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:chime

nbf_note_chime_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:chime

nbf_note_chime_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:chime

nbf_note_chime_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:chime

nbf_note_chime_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:chime

nbf_note_chime_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:chime

nbf_note_chime_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:chime

nbf_note_chime_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:chime

nbf_note_chime_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:chime

nbf_note_chime_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:chime

nbf_note_chime_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:chime

nbf_note_chime_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:chime

nbf_note_chime_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:chime

nbf_note_chime_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:chime

nbf_note_chime_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:chime

nbf_note_chime_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:chime

nbf_note_chime_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:chime

nbf_note_chime_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:chime

nbf_note_chime_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:chime

## guitar ##
nbf_note_guitar_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:guitar

nbf_note_guitar_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:guitar

nbf_note_guitar_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:guitar

nbf_note_guitar_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:guitar

nbf_note_guitar_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:guitar

nbf_note_guitar_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:guitar

nbf_note_guitar_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:guitar

nbf_note_guitar_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:guitar

nbf_note_guitar_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:guitar

nbf_note_guitar_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:guitar

nbf_note_guitar_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:guitar

nbf_note_guitar_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:guitar

nbf_note_guitar_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:guitar

nbf_note_guitar_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:guitar

nbf_note_guitar_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:guitar

nbf_note_guitar_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:guitar

nbf_note_guitar_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:guitar

nbf_note_guitar_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:guitar

nbf_note_guitar_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:guitar

nbf_note_guitar_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:guitar

nbf_note_guitar_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:guitar

nbf_note_guitar_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:guitar

nbf_note_guitar_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:guitar

nbf_note_guitar_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:guitar

nbf_note_guitar_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:guitar

## xylophone ##
nbf_note_xylophone_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:xylophone

nbf_note_xylophone_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:xylophone

nbf_note_xylophone_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:xylophone

nbf_note_xylophone_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:xylophone

nbf_note_xylophone_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:xylophone

nbf_note_xylophone_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:xylophone

nbf_note_xylophone_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:xylophone

nbf_note_xylophone_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:xylophone

nbf_note_xylophone_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:xylophone

nbf_note_xylophone_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:xylophone

nbf_note_xylophone_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:xylophone

nbf_note_xylophone_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:xylophone

nbf_note_xylophone_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:xylophone

nbf_note_xylophone_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:xylophone

nbf_note_xylophone_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:xylophone

nbf_note_xylophone_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:xylophone

nbf_note_xylophone_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:xylophone

nbf_note_xylophone_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:xylophone

nbf_note_xylophone_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:xylophone

nbf_note_xylophone_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:xylophone

nbf_note_xylophone_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:xylophone

nbf_note_xylophone_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:xylophone

nbf_note_xylophone_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:xylophone

nbf_note_xylophone_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:xylophone

nbf_note_xylophone_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:xylophone

## iron_xylophone ##
nbf_note_iron_xylophone_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:iron_xylophone

nbf_note_iron_xylophone_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:iron_xylophone

nbf_note_iron_xylophone_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:iron_xylophone

nbf_note_iron_xylophone_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:iron_xylophone

nbf_note_iron_xylophone_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:iron_xylophone

nbf_note_iron_xylophone_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:iron_xylophone

nbf_note_iron_xylophone_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:iron_xylophone

nbf_note_iron_xylophone_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:iron_xylophone

nbf_note_iron_xylophone_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:iron_xylophone

nbf_note_iron_xylophone_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:iron_xylophone

nbf_note_iron_xylophone_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:iron_xylophone

nbf_note_iron_xylophone_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:iron_xylophone

nbf_note_iron_xylophone_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:iron_xylophone

nbf_note_iron_xylophone_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:iron_xylophone

nbf_note_iron_xylophone_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:iron_xylophone

nbf_note_iron_xylophone_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:iron_xylophone

nbf_note_iron_xylophone_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:iron_xylophone

nbf_note_iron_xylophone_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:iron_xylophone

nbf_note_iron_xylophone_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:iron_xylophone

nbf_note_iron_xylophone_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:iron_xylophone

nbf_note_iron_xylophone_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:iron_xylophone

nbf_note_iron_xylophone_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:iron_xylophone

nbf_note_iron_xylophone_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:iron_xylophone

nbf_note_iron_xylophone_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:iron_xylophone

nbf_note_iron_xylophone_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:iron_xylophone

## didgeridoo ##
nbf_note_didgeridoo_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:didgeridoo

nbf_note_didgeridoo_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:didgeridoo

nbf_note_didgeridoo_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:didgeridoo

nbf_note_didgeridoo_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:didgeridoo

nbf_note_didgeridoo_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:didgeridoo

nbf_note_didgeridoo_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:didgeridoo

nbf_note_didgeridoo_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:didgeridoo

nbf_note_didgeridoo_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:didgeridoo

nbf_note_didgeridoo_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:didgeridoo

nbf_note_didgeridoo_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:didgeridoo

nbf_note_didgeridoo_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:didgeridoo

nbf_note_didgeridoo_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:didgeridoo

nbf_note_didgeridoo_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:didgeridoo

nbf_note_didgeridoo_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:didgeridoo

nbf_note_didgeridoo_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:didgeridoo

nbf_note_didgeridoo_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:didgeridoo

nbf_note_didgeridoo_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:didgeridoo

nbf_note_didgeridoo_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:didgeridoo

nbf_note_didgeridoo_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:didgeridoo

nbf_note_didgeridoo_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:didgeridoo

nbf_note_didgeridoo_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:didgeridoo

nbf_note_didgeridoo_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:didgeridoo

nbf_note_didgeridoo_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:didgeridoo

nbf_note_didgeridoo_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:didgeridoo

nbf_note_didgeridoo_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:didgeridoo

## bit ##
nbf_note_bit_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:bit

nbf_note_bit_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:bit

nbf_note_bit_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:bit

nbf_note_bit_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:bit

nbf_note_bit_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:bit

nbf_note_bit_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:bit

nbf_note_bit_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:bit

nbf_note_bit_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:bit

nbf_note_bit_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:bit

nbf_note_bit_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:bit

nbf_note_bit_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:bit

nbf_note_bit_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:bit

nbf_note_bit_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:bit

nbf_note_bit_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:bit

nbf_note_bit_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:bit

nbf_note_bit_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:bit

nbf_note_bit_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:bit

nbf_note_bit_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:bit

nbf_note_bit_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:bit

nbf_note_bit_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:bit

nbf_note_bit_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:bit

nbf_note_bit_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:bit

nbf_note_bit_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:bit

nbf_note_bit_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:bit

nbf_note_bit_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:bit

## banjo ##
nbf_note_banjo_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:banjo

nbf_note_banjo_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:banjo

nbf_note_banjo_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:banjo

nbf_note_banjo_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:banjo

nbf_note_banjo_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:banjo

nbf_note_banjo_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:banjo

nbf_note_banjo_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:banjo

nbf_note_banjo_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:banjo

nbf_note_banjo_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:banjo

nbf_note_banjo_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:banjo

nbf_note_banjo_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:banjo

nbf_note_banjo_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:banjo

nbf_note_banjo_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:banjo

nbf_note_banjo_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:banjo

nbf_note_banjo_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:banjo

nbf_note_banjo_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:banjo

nbf_note_banjo_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:banjo

nbf_note_banjo_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:banjo

nbf_note_banjo_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:banjo

nbf_note_banjo_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:banjo

nbf_note_banjo_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:banjo

nbf_note_banjo_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:banjo

nbf_note_banjo_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:banjo

nbf_note_banjo_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:banjo

nbf_note_banjo_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:banjo

## harp ##
nbf_note_harp_0FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:0_FSharp def.instrument:harp

nbf_note_harp_1G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:1_G def.instrument:harp

nbf_note_harp_2GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:2_GSharp def.instrument:harp

nbf_note_harp_3A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:3_A def.instrument:harp

nbf_note_harp_4ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:4_ASharp def.instrument:harp

nbf_note_harp_5B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:5_B def.instrument:harp

nbf_note_harp_6C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:6_C def.instrument:harp

nbf_note_harp_7CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:7_CSharp def.instrument:harp

nbf_note_harp_8D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:8_D def.instrument:harp

nbf_note_harp_9DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:9_DSharp def.instrument:harp

nbf_note_harp_10E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:10_E def.instrument:harp

nbf_note_harp_11F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:11_F def.instrument:harp

nbf_note_harp_12FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:12_FSharp def.instrument:harp

nbf_note_harp_13G:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:13_G def.instrument:harp

nbf_note_harp_14GSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:14_GSharp def.instrument:harp

nbf_note_harp_15A:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:15_A def.instrument:harp

nbf_note_harp_16ASharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:16_ASharp def.instrument:harp

nbf_note_harp_17B:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:17_B def.instrument:harp

nbf_note_harp_18C:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:18_C def.instrument:harp

nbf_note_harp_19CSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:19_CSharp def.instrument:harp

nbf_note_harp_20D:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:20_D def.instrument:harp

nbf_note_harp_21DSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:21_DSharp def.instrument:harp

nbf_note_harp_22E:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:22_E def.instrument:harp

nbf_note_harp_23F:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:23_F def.instrument:harp

nbf_note_harp_24FSharp:
    type: task
    definitions: player
    script:
    - run nbf_note_proc def.player:<[player]> def.note:24_FSharp def.instrument:harp
