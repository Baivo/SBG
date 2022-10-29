note_clear:
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

note_pling_a:
    type: task
    debug: false
    definitions: player
    script:
    - if <[player].flag[note]> != a:
        - flag <[player]> note:a
        - playsound <[player].location> <[player].location.find_players_within[32]> sound:block_note_block_pling volume:1.0 pitch:0.594604 sound_category:master
    - else:
        - determine passively cancelled
note_pling_b:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != b:
        - flag <[player]> note:b
        - playsound <[player].location> <[player].location.find_players_within[32]> sound:block_note_block_pling volume:1.0 pitch:0.667420 sound_category:master
    - else:
        - determine passively cancelled
note_pling_c:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != c:
        - flag <[player]> note:c
        - playsound <[player].location> <[player].location.find_players_within[32]> sound:block_note_block_pling volume:1.0 pitch:0.707107 sound_category:master
    - else:
        - determine passively cancelled
note_pling_d:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != d:
        - flag <[player]> note:d
        - playsound <[player].location> <[player].location.find_players_within[32]> sound:block_note_block_pling volume:1.0 pitch:0.793701 sound_category:master
    - else:
        - determine passively cancelled
note_pling_e:
    type: task
    definitions: player
    script:
    - if <[player].flag[note]> != e:
        - flag <[player]> note:e
        - playsound <[player].location> <[player].location.find_players_within[32]> sound:block_note_block_pling volume:1.0 pitch:0.890899 sound_category:master
    - else:
        - determine passively cancelled
