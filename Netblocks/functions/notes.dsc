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
        0_FSharp: 0.5
        1_G: 0.529732
        2_GSharp: 0.561231
        3_A: 0.594604
        4_ASharp: 0.629961
        5_B: 0.667420
        6_C: 0.707107
        7_CSharp: 0.749154
        8_D: 0.793701
        9_DSharp: 0.840896
        10_E: 0.890899
        11_F: 0.943874
        12_FSharp: 1.0
        13_G: 1.059463
        14_GSharp: 1.122462
        15_A: 1.189207
        16_ASharp: 1.259921
        17_B: 1.334840
        18_C: 1.414214
        29_CSharp: 1.498307
        20_D: 1.587401
        21_DSharp: 1.681793
        22_E: 1.781797
        23_F: 1.887749
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

## Pling ##
nbf_note_0FSharp_pling:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != 0fSharp:
        - flag <[player]> note:0fSharp
        - playsound <[player].location> sound:block_note_block_pling pitch:<script[note_data].data_key[pitches.0_FSharp]>
        - playeffect <[player].location> effect:note data:<script[note_data].data_key[colours.0_FSharp]>

nbf_note_1G_pling:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != 1g:
        - flag <[player]> note:1g
        - playsound <[player].location> sound:block_note_block_pling pitch:<script[note_data].data_key[pitches.1_G]>
        - playeffect <[player].location> effect:note data:<script[note_data].data_key[colours.1_G]>

nbf_note_2GSharp_pling:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != 2gSharp:
        - flag <[player]> note:2gSharp
        - playsound <[player].location> sound:block_note_block_pling pitch:<script[note_data].data_key[pitches.2_GSharp]>
        - playeffect <[player].location> effect:note data:<script[note_data].data_key[colours.2_GSharp]>

nbf_note_3A_pling:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != 3a:
        - flag <[player]> note:3a
        - playsound <[player].location> sound:block_note_block_pling pitch:<script[note_data].data_key[pitches.3_A]>
        - playeffect <[player].location> effect:note data:<script[note_data].data_key[colours.3_A]>

nbf_note_4ASharp_pling:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != 4aSharp:
        - flag <[player]> note:4aSharp
        - playsound <[player].location> sound:block_note_block_pling pitch:<script[note_data].data_key[pitches.4_ASharp]>
        - playeffect <[player].location> effect:note data:<script[note_data].data_key[colours.4_ASharp]>

nbf_note_5B_pling:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != 5b:
        - flag <[player]> note:5b
        - playsound <[player].location> sound:block_note_block_pling pitch:<script[note_data].data_key[pitches.5_B]>
        - playeffect <[player].location> effect:note data:<script[note_data].data_key[colours.5_B]>

nbf_note_6C_pling:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != 6c:
        - flag <[player]> note:6c
        - playsound <[player].location> sound:block_note_block_pling pitch:<script[note_data].data_key[pitches.6_C]>
        - playeffect <[player].location> effect:note data:<script[note_data].data_key[colours.6_C]>
