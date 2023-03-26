health_bar:
    type: world
    debug: false
    events:
        on !player damaged by player:
            - define eh <context.entity.health.sub[<context.final_damage>].round_up>
            - if <[eh]> > 0 && <[eh]> < 11:
                - define health <context.entity.health.sub[<context.final_damage>].round_up>
                - define healthbar <element[♥].repeat[<[health]>]>
                - rename <&color[#E80000]><[healthbar]> t:<context.entity> for:<server.online_players> per_player
            - else if <[eh]> >= 11:
                - define health <context.entity.health.sub[<context.final_damage>].round_up>
                - define healthbar <&color[#E80000]><element[♥]><&nbsp><&c><[health]>
                - rename <[healthbar]> t:<context.entity> for:<server.online_players> per_player
            - else:
                - rename cancel t:<context.entity> per_player
            - wait 5t
            - rename cancel t:<context.entity> per_player