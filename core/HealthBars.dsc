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

            - define remainingHealth <[entityHealth].mul[<[healthBarSize]>]>
            - define damageDone <[healthBarSize].sub[<[remainingHealth]>]>

            - if <context.entity.health_percentage> > 50:
                - define color #00FF00
            - else if <context.entity.health_percentage> > 25:
                - define color #FFFF00
            - else:
                - define color #FF0000

            - define numDisplay <context.entity.health.round_down><element[/]><context.entity.health_max><&nbsp>
            - define perDisplay <&f><&nbsp><[entityHealth].mul[100].round_down><&pc>

            - define healthBar <[numDisplay]><&7><&l><&lc><&color[<[color]>]><element[|].repeat[<[remainingHealth]>]><&8><element[|].repeat[<[damageDone]>]><&7><&l><&rc><[perDisplay]>
            - adjust <context.entity> custom_name:<[healthBar]>
            - wait 20t
            - adjust <context.entity> custom_name