EV_Events:
    type: world
    debug: false
    events:
        on player places EV_Harvester_Dev:
        - flag server Harvester.<context.location>:<player>
        - flag server Inventory.<context.location>:<inventory[Harvester_Inventory]>
        - flag <context.location> EV_Harvester_Dev
        - note <inventory[<server.flag[Inventory.<context.location>]>]> as:Harvester_Inventory_<context.location>
        on player breaks end_portal_frame location_flagged:Ev_Harvester_Dev:
        - flag server Harvester.<context.location>:!
        - flag server Inventory.<context.location>:!
        - flag <context.location> EV_Harvester_Dev:!
        - note remove as:Harvester_Inventory_<context.location>
        on delta time secondly every:1:
        - foreach <server.flag[Harvester]> key:block as:player:
            - run Harvester_Script def.harvester:<[block]> def.owner:<[player]>
            - wait 5t
        on player right clicks block location_flagged:EV_Harvester_Dev:
        - define harvester <context.location>
        - define player <server.flag[Harvester.<[harvester]>]>
        - if <[player]> == <player>:
            # - narrate "<&a>You own this!"
            - inventory open d:Harvester_Inventory_<[harvester]>
        - else:
            - narrate "<&c>You do not own this Harvester!"
            - narrate "<&c>It is owned by <&e><[player].display_name>"
        on player left clicks block location_flagged:EV_Harvester_Dev:
        - define harvester <context.location>
        - define player <server.flag[Harvester.<[harvester]>]>
        # - determine cancelled passively

Harvester_Script:
    type: task
    debug: false
    definitions: harvester
    script:
        - define inventory <inventory[Harvester_Inventory_<[harvester]>]>
        - define items <script[Harvester_Items].data_key[Ores]>
        - define item <[items].random>
        - inventory copy d:<[inventory]> o:<[inventory].include[<[item]>]>
        - run Harvester_Particles def.seed:<[harvester].center.above[2]>
        - fakespawn <entity[dropped_item[gravity=false;item=<[item]>]]> at:<[harvester].center.above[2.0]> duration:20t players:<server.online_players> save:fakeitem
        - define fakeitem <entry[fakeitem].faked_entity>
        - shoot <[fakeitem]> origin:<[fakeitem].location> destination:<[harvester].center.above[1]> speed:0.1

Harvester_Particles:
    type: task
    definitions: seed
    script:
    - define prng <util.random_decimal.mul[2]>
    - random:
        - define rng <util.random_decimal.mul[2]>
        - define rng <util.random_decimal.mul[2].mul[-1]>
    # - playeffect effect:portal at:<[seed].above[0.5].add[<[rng]>,0,<[rng]>]> quantity:10 offset:0,0,0 velocity:<[rng]>,0,<[rng]> speed:2
    - foreach <[seed].above[0.7].points_around_y[radius=1;points=10]> as:ring:
        - playeffect at:<[ring]> effect:enchantment_table offset:0,0,0 velocity:0,0,0 data:0
        - wait 2t

Harvester_Inventory:
    type: inventory
    inventory: chest
    title: <&5>Harvester Dev 1.0
    size: 54

Harvester_Menu:
    type: inventory
    inventory: dispenser
    title: <&5>Harvester Dev 1.0 Menu
    size: 9
    gui: true
    slots:
    - [] [] []
    - [] [] []
    - [] [] []

EV_Harvester_Dev:
  type: item
  material: end_portal_frame
  display name: <&5>Harvester Dev 1.0
  lore:
  - <&color[#a11300]>!CONFIDENTIAL!
  - <&color[#968200]>Removal of this item from BIVCO Lab 1
  - <&color[#968200]>Will result in immediate termination
  mechanisms:
    custom_model_data: 17
  recipes:
    1:
      type: shapeless
      input: <item[barrier]>|<item[end_portal_frame]>

Harvester_items:
    type: data
    ores:
        - diamond_ore
        - emerald_ore
        - gold_ore
        - iron_ore
        - lapis_ore
        - redstone_ore
        - coal_ore
        - nether_quartz_ore
        - ancient_debris
        - copper_ore
        - deepslate_copper_ore
        - deepslate_diamond_ore
        - deepslate_emerald_ore
        - deepslate_gold_ore
        - deepslate_iron_ore
        - deepslate_lapis_ore
        - deepslate_redstone_ore
        - deepslate_coal_ore
