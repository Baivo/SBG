health_bar:
    type: world
    debug: false
    events:
        on !player damaged by player:
            - choose <context.entity.health.sub[<context.final_damage>]>:
                - case > 10:
                    - define health <context.entity.health.sub[<context.final_damage>].round_up>
                    - define healthbar <&color[#E80000]><element[♥]><&nbsp><&c><[health]>
                    - rename <[healthbar]> t:<context.entity> for:<server.online_players>
                - case > 0:
                    - define health <context.entity.health.sub[<context.final_damage>].round_up>
                    - define healthbar <element[♥].repeat[<[health]>]>
                    - rename <&color[#E80000]><[healthbar]> t:<context.entity> for:<server.online_players>
                - default:
                    - rename cancel t:<context.entity>
                - wait 5t
                - rename cancel t:<context.entity>