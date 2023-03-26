health_bar:
    type: world
    debug: false
    events:
        on !player damaged by player:
            - define eh <context.entity.health.sub[<context.final_damage>].round_up>
            - if <[eh]> > 0 && <[eh]> < 11:
                - define healthbar <&color[#E80000]><element[♥].repeat[<[eh]>]>
                - adjust <context.entity> custom_name:<[healthbar]>
            - else if <[eh]> >= 11:
                - define healthbar <&color[#E80000]><element[♥]><&nbsp><&c><[eh]>
                - adjust <context.entity> custom_name:<[healthbar]>
            - wait 5t
            - adjust <context.entity> custom_name:!