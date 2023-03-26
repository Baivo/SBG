health_bar:
    type: world
    debug: false
    events:
        on !player damaged by player:
            - if <context.entity.health.sub[<context.final_damage>]> > 0:
                - define health <context.entity.health.sub[<context.final_damage>].round_up>
                - define healthbar <element[♥].repeat[<[health]>]>
                - rename <&color[#E80000]><[healthbar]> t:<context.entity> for:<server.online_players>
            - else:
                - rename cancel t:<context.entity> for:<server.online_players>