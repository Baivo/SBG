nbf_util_ttm:
    type: task
    definitions: player
    script:
    - ratelimit <player> 1s
    - flag <player> tinktree expire:1s

nbf_util_ttm_handler:
    type: world
    events:
        on player opens chest flagged:tinktree:
        - ratelimit <player> 1s
        - execute as_server "sudo <player.name> ttm"
