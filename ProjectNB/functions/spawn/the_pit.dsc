# RTP pit victims
nbf_serverspawn_thepit:
    type: task
    definitions: player
    debug: false
    script:
        - ratelimit <player> 30s
        - execute as_op "sudo <[player].name> rtp"
        - cast slow_falling duration:10s
