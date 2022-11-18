# Prompt the rules quiz for the player
nbf_serverspawn_rulesquiz:
    type: task
    definitions: player
    debug: true
    script:
        - ratelimit <player> 1m
        - execute as_server "sudo <[player].name> rules"
