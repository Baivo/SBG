healthbar:
    type: world
    debug: false
    events:
        on !player damaged by player:
        - if <context.entity.attribute_value[GENERIC_ATTACK_DAMAGE].if_null[0]> == 0:
            - stop
        - if <context.entity.health.sub[<context.final_damage>]> > 0:
            - define healthBarSize 20
            - define entityHealthPerc <context.entity.health.sub[<context.final_damage>].div[<context.entity.health_max>]>
            - define remainingHealth <[entityHealthPerc].mul[<[healthBarSize]>]>
            - define damageDone <[healthBarSize].sub[<[remainingHealth]>]>
#
            - if <[entityHealthPerc]> > 0.66:
                - define color #66ff66
            - else if <[entityHealthPerc]> > 0.33:
                - define color #d9c252
            - else:
                - define color #d9525e
            - define perDisplay <&7><[entityHealthPerc].mul[100].round_down><&pc>
#
            - define armorDisplay <&b><&o>🛡<&7><&l><context.entity.armor_bonus.if_null[0]>
            - define healthDisplay <&c><&o>❤<&7><&lb><&color[<[color]>]><element[|].repeat[<[remainingHealth]>]><&8><element[|].repeat[<[damageDone]>]><&7><&rb>
            - define damageDisplay <&e>🗡<&7><&l><context.entity.attribute_value[GENERIC_ATTACK_DAMAGE].if_null[0]>
#
            - define healthBar <[armorDisplay]><&nbsp><[healthDisplay]><&nbsp><[damageDisplay]>
            - adjust <context.entity> custom_name:<[healthBar]>
        - else:
            - adjust <context.entity> custom_name
        on player damaged by !player:
        - adjust <context.damager> custom_name