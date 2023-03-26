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

        on !player damaged by player:
        - if <context.entity.health.sub[<context.final_damage>]> > 0:
            - define healthBarSize 20
            - define entityHealthPerc <context.entity.health.sub[<context.final_damage>].div[<context.entity.health_max>]>

            - define remainingHealth <[entityHealthPerc].mul[<[healthBarSize]>]>
            - define damageDone <[healthBarSize].sub[<[remainingHealth]>]>

            - if <context.entity.health_percentage> > 50:
                - define color #00CF00
            - else if <context.entity.health_percentage> > 25:
                - define color #FFFF00
            - else:
                - define color #FF0000

            - define numDisplay <&color[<[color]>]><context.entity.health.round_down><element[/]><context.entity.health_max><&nbsp>
            - define perDisplay <&7><[entityHealthPerc].mul[100].round_down><&pc>

            - define healthBar <&c>♥<&nbsp><&7><&lb><&color[<[color]>]><element[|].repeat[<[remainingHealth]>]><&8><element[|].repeat[<[damageDone]>]><&7><&rb><&nbsp><[perDisplay]>
            - adjust <context.entity> custom_name:<[healthBar]>
        - else:
            - adjust <context.entity> custom_name

            # - wait 10t
            # - adjust <context.entity> custom_name