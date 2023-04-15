SafeRandomTeleport:
    type: command
    name: rtp
    description: Safely teleports you to a random location.
    usage: /rtp
    debug: true
    script:
    ## Radius of the area to teleport in. Default is 10000.
    - define tpRadius 10000
    ## Only targets world.
    - if <player.has_flag[rtping]>:
        - narrate "Please wait for the current search to finish."
        - stop
    - flag <player> rtping
    - define isSafe false
    - narrate "<&7><&o>Finding a random location..."
    - while <[isSafe]> != true:
        - define locationx <util.random.int[-<[tpRadius]>].to[<[tpRadius]>]>
        - define locationz <util.random.int[-<[tpRadius]>].to[<[tpRadius]>]>
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
