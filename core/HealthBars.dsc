health_bar:
    type: world
    debug: false
    events:
        on !player damaged by player:
            - define health <context.entity.health>
            - adjust <context.entity> custom_name:<&4>♥<&sp><&c><[health].round_to[0]>
