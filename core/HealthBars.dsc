# health_bar:
#     type: world
#     debug: false
#     events:
#         on !player damaged by player:
#             - define eh <context.entity.health.sub[<context.final_damage>].round_up>
#             - if <[eh]> > 0 && <[eh]> < 11:
#                 - define healthbar <&color[#E80000]><element[♥].repeat[<[eh]>]>
#                 - adjust <context.entity> custom_name:<[healthbar]>
#             - else if <[eh]> >= 11:
#                 - define healthbar <&color[#E80000]><element[♥]><&nbsp><&c><[eh]>
#                 - adjust <context.entity> custom_name:<[healthbar]>
#             - wait 5t
#             - adjust <context.entity> custom_name

adv_healthbar:
    type: world
    debug: false
    events:
        after !player damaged by player:
            - define healthBarSize 20
            - define entityHealth <context.entity.health_percentage.mul[0.01]>
            - define greenBars <[entityHealth].mul[<[healthBarSize]>]>
            - define redBars <[healthBarSize].sub[<[greenBars]>]>
            - define healthBar <&lb><&color[#00FF00]><element[▌].repeat[<[greenBars]>]><&color[#FF0000]><element[▌].repeat[<[redBars]>]><&rb>
            - adjust <context.entity> custom_name:<[healthBar]>
            - wait 5t
            - adjust <context.entity> custom_name