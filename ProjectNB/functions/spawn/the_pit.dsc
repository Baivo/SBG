# RTP pit victims
nbf_serverspawn_rulesquiz:
    type: task
    definitions: player
    debug: false
    script:
        - ratelimit <player> 30s
        - execute as_op "sudo <[player].name> rtp"
