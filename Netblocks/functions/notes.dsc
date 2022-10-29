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
            FSharp: 0.5
            G: 0.529732
            GSharp: 0.561231
            A: 0.594604
            ASharp: 0.629961
            B: 0.667420
            C: 0.707107
            CSharp: 0.749154
            D: 0.793701
            DSharp: 0.840896
            E: 0.890899
            F: 0.943874
            FSharp: 1.0
        Octave2:
            FSharp: 1.0
            G: 1.059463
            GSharp: 1.122462
            A: 1.189207
            ASharp: 1.259921
            B: 1.334840
            C: 1.414214
            CSharp: 1.498307
            D: 1.587401
            DSharp: 1.681793
            E: 1.781797
            F: 1.887749
            FSharp: 2.0
    colours:
        Octave1:
            FSharp: 0
            G: 0.042
            GSharp: 0.083
            A: 0.125
            ASharp: 0.167
            B: 0.208
            C: 0.250
            CSharp: 0.292
            D: 0.333
            DSharp: 0.375
            E: 0.417
            F: 0.458
            FSharp: 0.500
        Octave2:
            FSharp: 0.500
            G: 0.542
            GSharp: 0.583
            A: 0.625
            ASharp: 0.667
            B: 0.708
            C: 0.750
            CSharp: 0.792
            D: 0.833
            DSharp: 0.875
            E: 0.917
            F: 0.958
            FSharp: 1.000

## Pling ##
nbf_note_0FSharp_pling:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != 0fSharp:
        - flag <[player]> note:0fSharp
        - playsound <[player].location> sound:block_note_block_pling pitch:0.5
        - playeffect <[player].location> effect:note
