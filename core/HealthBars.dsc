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

            - if <[entityHealthPerc]> > 0.66:
                - define color #32a852
            - else if <[entityHealthPerc]> > 0.33:
                - define color #d9c252
            - else:
                - define color #d9525e

            - define perDisplay <&7><[entityHealthPerc].mul[100].round_down><&pc>

            - define armorDisplay <&7><&lb><&b><&l><&o>🛡<&7><context.entity.armor_bonus><&7><&rb>
            - define healthDisplay <&7><&lb><&c>♥<&color[<[color]>]><element[|].repeat[<[remainingHealth]>]><&8><element[|].repeat[<[damageDone]>]><&7><&rb>

            - define healthBar <[armorDisplay]><&nbsp><[healthDisplay]>
            - adjust <context.entity> custom_name:<[healthBar]>
        - else:
            - adjust <context.entity> custom_name