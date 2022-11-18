# Author: Baivo
# Needs looking at r.e. Murgu menutool

#     - [spoints_shop_nightvision_item] [spoints_shop_fireresistance_item] [] [] [] [] [] [spoints_shop_day_item] [spoints_shop_health_item]

# nbf_effect_nbdata:
#   type: task
#   definitions: player|effect|power|duration
#   script:
#     - cast <[effect].if_null[SPEED]> duration:<[duration].if_null[3s]> amplifier:<[power].if_null[0]> <[player]>


spoints_shop_row1_events:
    type: world
    debug: false
    events:
        on player clicks spoints_shop_nightvision_item in inventory:
            - ratelimit <player> 1s
            - run spoints_shop_transact def.player:<player> def.cost:10 def.script:<script[spoints_shop_nightvision_script]>
        on player clicks spoints_shop_health_item in inventory:
            - ratelimit <player> 1s
            - run spoints_shop_transact def.player:<player> def.cost:250 def.script:<script[spoints_shop_health_script]>

# Row1 - template - effect
spoints_shop_effect_item:
    type: item
    material: golden_carrot
    display name: <&3>effect!
    lore:
    - <&sp>
    - <&7>Costs: <&a>10 <&7>points
    - <&sp>
    - <&7><&o>Lasts until death

spoints_shop_effect_script:
    type: task
    debug: false
    definitions: player
    script:
        - cast NIGHT_VISION amplifier:0 d:999999 hide_particles <[player]>
        - inventory close d:<inventory[Spoints_Shop_<[player].name>]>
        - narrate "<&3>effect enabled.<&nl>Don't forget to still place torches." targets:<[player]>

# Row1 - Slot1 - Night Vision
spoints_shop_nightvision_item:
    type: item
    material: golden_carrot
    display name: <&color[#396902]>Night vision!
    lore:
    - <&sp>
    - <&7>Costs: <&a>10 <&7>points
    - <&sp>
    - <&7><&o>Lasts until death

spoints_shop_nightvision_script:
    type: task
    debug: false
    definitions: player
    script:
        - cast NIGHT_VISION amplifier:0 d:999999 hide_particles <[player]>
        - inventory close d:<inventory[Spoints_Shop_<[player].name>]>
        - narrate "<&color[#396902]>Night vision enabled.<&nl>Don't forget to still place torches." targets:<[player]>

# Row1 - Slot 2 - Fire Resistance
spoints_shop_fireresistance_item:
    type: item
    material: golden_carrot
    display name: <element[Fire Resistance!].color_gradient[FROM=#944612;TO=#7d2500]>
    lore:
    - <&sp>
    - <&7>Costs: <&a>30 <&7>points
    - <&sp>
    - <&7><&o>Lasts until death

spoints_shop_fireresistance_script:
    type: task
    debug: false
    definitions: player
    script:
        - cast FIRE_RESISTANCE amplifier:0 d:999999 hide_particles <[player]>
        - inventory close d:<inventory[Spoints_Shop_<[player].name>]>
        - narrate "<&color[#c73c02]>Nice Work, hot stuff!" targets:<[player]>


# Row1 - Slot8 - Day
spoints_shop_day_item:
    type: item
    material: clock
    display name: <&e>Make it Day-Time!
    lore:
    - <&sp>
    - <&7>Costs: <&a>10 <&7>points

spoints_shop_day_script:
    type: task
    debug: false
    definitions: player
    script:
        - time 0
        - inventory close d:<inventory[Spoints_Shop_<[player].name>]>
        - narrate "<&a>Time set to day!" targets:<[player]>

# Row1 - Slot9 - Healthup
spoints_shop_health_item:
    type: item
    material: red_dye
    display name: <&c>Upgrade your max health!
    lore:
    - <&sp>
    - <&7>Costs: <&a>250 <&7>points

spoints_shop_health_script:
    type: task
    debug: false
    definitions: player
    script:
        - ratelimit <player> 1s
        - adjust <[player]> max_health:<player.health_max.add_int[2]>
        - inventory close d:<inventory[Spoints_Shop_<[player].name>]>
        - narrate "<&a>Your maximum HP is now <&c><player.health_max.div[2]><&a> hearts!" targets:<[player]>
