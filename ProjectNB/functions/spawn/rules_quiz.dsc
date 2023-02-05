# Prompt the rules quiz for the player
nbf_serverspawn_rulesquiz:
    type: task
    definitions: player
    debug: false
    script:
        - ratelimit <player> 30s
        - execute as_player "rules"
