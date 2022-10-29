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
        Octave1:
            F#: 0.5
            G: 0.529732
            G#: 0.561231
            A: 0.594604
            A#: 0.629961
            B: 0.667420
            C: 0.707107
            C#: 0.749154
            D: 0.793701
            D#: 0.840896
            E: 0.890899
            F: 0.943874
            F#: 1.0
        Octave2:
            F#: 1.0
            G: 1.059463
            G#: 1.122462
            A: 1.189207
            A#: 1.259921
            B: 1.334840
            C: 1.414214
            C#: 1.498307
            D: 1.587401
            D#: 1.681793
            E: 1.781797
            F: 1.887749
            F#: 2.0
    colours:
        Octave1:
            F#: 0
            G: 0.042
            G#: 0.083
            A: 0.125
            A#: 0.167
            B: 0.208
            C: 0.250
            C#: 0.292
            D: 0.333
            D#: 0.375
            E: 0.417
            F: 0.458
            F#: 0.500
        Octave2:
            F#: 0.500
            G: 0.542
            G#: 0.583
            A: 0.625
            A#: 0.667
            B: 0.708
            C: 0.750
            C#: 0.792
            D: 0.833
            D#: 0.875
            E: 0.917
            F: 0.958
            F#: 1.000

## Pling ##
note_pling_a:
    type: task
    debug: false
    definitions: player
    script:
    - if <[player].flag[note]> != a:
        - flag <[player]> note:a
        - playsound <[player].location> sound:block_note_block_pling volume:1.0 pitch:0.594604
note_pling_b:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != b:
        - flag <[player]> note:b
        - playsound <[player].location> sound:block_note_block_pling volume:1.0 pitch:0.667420
note_pling_c:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != c:
        - flag <[player]> note:c
        - playsound <[player].location> sound:block_note_block_pling volume:1.0 pitch:0.707107
note_pling_d:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != d:
        - flag <[player]> note:d
        - playsound <[player].location> sound:block_note_block_pling volume:1.0 pitch:0.793701
note_pling_e:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != e:
        - flag <[player]> note:e
        - playsound <[player].location> sound:block_note_block_pling volume:1.0 pitch:0.890899
