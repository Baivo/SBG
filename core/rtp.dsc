RandomTeleport:
    type: command
    name: rtp
    description: Random teleporting!
    usage: /rtp
    debug: true
    script:
    - if <player.has_flag[rtping]>:
        - narrate "Please wait for the current search to finish."
        - stop
    - flag <player> rtping
    - define isSafe false
    - narrate "<&7><&o>Finding a random location..."
    - while <[isSafe]> != true:
        - define locationx <util.random.int[-10000].to[10000]>
        - define locationz <util.random.int[-10000].to[10000]>
        - define loccheck <location[<[locationx]>,0,<[locationz]>,0,0,world]>
        - chunkload <location[<[loccheck]>].chunk> duration:5s
        - define seed <[loccheck].highest>
        - foreach <[seed].find_spawnable_blocks_within[16]> as:cand:
            - if <[cand].is_spawnable>:
                - define dest <[cand]>
                - define isSafe true
                - foreach stop
            - else:
                - foreach next
        - wait 1s
    - narrate "<&7><&o>Location found. Enjoy your stay!"
    - teleport <player> <[dest]>
    - flag <player> rtping:!
