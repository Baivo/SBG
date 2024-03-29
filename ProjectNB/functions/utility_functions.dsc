# Author: Baivo
# No versions!
# Example or utility functions to perform actions using netblocks. 

# Naming conventions: 
# ScriptType_FunctionGroup_Function
# nbf_*: Netblock function
# nbfe_*: Netblock function event for netblock function
# nbf_util_*: Netblock function belonging to the 'util' category
# nbf_util_zap: Netblock function 'zap' belonging to the 'util' category
# nbfe_util_zap: Event scripts that support the netblock function 'zap' belonging to the 'util' category

nbf_util_showdebug:
  type: task
  definitions: loc
  script:
    - ratelimit <player> 1s
    - debugblock <[loc]> color:0,255,0 players:<[loc].find_players_within[32]> d:25t

nbf_util_zap:
  type: task
  definitions: player
  script:
    - hurt 1 <[player]>
    - playeffect at:<[player].eye_location.below[1]> effect:spark quantity:5 offset:1


nbf_util_trisepath:
  type: task
  debug: false
  definitions: player|netblock
  script:
    - ratelimit <[player]> 1t
    - playeffect at:<[player].location> effect:enchantment_table quantity:3 offset:2

nbf_util_pylonpath:
  type: task
  debug: false
  definitions: player|netblock
  script:
    - ratelimit <[player]> 1t
    - playeffect at:<[player].location> effect:dragon_breath quantity:5 offset:1
  
nbf_util_tp2netblock:
  type: task
  debug: false
  definitions: player|netblock
  script:
    - teleport <[player]> <[netblock]> relative
    - playeffect at:<[player].eye_location.below[1]> effect:portal_travel quantity:5 offset:1

nbf_util_playsound:
  type: task
  debug: false
  definitions: player
  script:
    - playsound <[player].location> sound:entity_axolotl_idle_air pitch:0.1 volume:0.3

nbf_util_lasergrid:
  type: task
  definitions: player
  script:
    - ratelimit <[player]> 1s
    - playeffect at:<[player].above[0.5]> effect:WAX_OFF offset:0.5,0.5,0.5 quantity:5
    - playsound <[player]> sound:ENCHANT_THORNS_HIT volume:0.5 pitch:1.3
    - flag <[player]> nbfence expire:1s
    - kill <[player]>
    - playsound <[player].location> <[player]> sound:bass custom volume:1
    - define number <util.random.int[1].to[999]>
    

nbfe_util_lazergrid:
  type: world
  events:
    on player dies:
      - if <player.has_flag[nbfence]>:
        - determine passively NO_MESSAGE
        - define number <util.random.int[1].to[999]>
        - random:
          - define message "<player.nameplate> was detected in a restricted area."
          - define message "<player.nameplate> attempted to enter a restricted area without clearance. This attempt was stopped by <[number]> high calibre rounds."
          - define message "<player.nameplate> has been voluntarily enrolled into the BIVCO organ donation program."
          - define message "<player.nameplate> encountered the consequences of their own actions."
        - announce <[message]>

nbf_util_relativetp:
  type: task
  definitions: player
  script:
    - if <[player].has_flag[Baivo]>:
      - teleport <[player]> <player.location.add[2,0,0]>

nbf_util_rosadancefloor:
    type: task
    definitions: trigger
    script:
    - ratelimit <player> 1t
    - define loc <[trigger].below[1]>
    - random:
        - define material <material[lime_concrete]>
        - define material <material[white_concrete]>
        - define material <material[black_concrete]>
        - define material <material[gray_concrete]>
        - define material <material[light_gray_concrete]>
        - define material <material[green_concrete]>
    - showfake <[material]> <[loc]> duration:3s players:<server.online_players>

nbf_util_dancefloor:
    type: task
    definitions: trigger
    script:
    - ratelimit <player> 1t
    - define loc <[trigger].below[1]>
    - random:
        - define material <material[red_concrete]>
        - define material <material[orange_concrete]>
        - define material <material[yellow_concrete]>
        - define material <material[lime_concrete]>
        - define material <material[light_blue_concrete]>
        - define material <material[pink_concrete]>
        - define material <material[purple_concrete]>
        # add more!
    - showfake <[material]> <[loc]> duration:1s players:<server.online_players>

nbf_util_bigdancefloor:
    type: task
    definitions: trigger
    script:
    - ratelimit <player> 1t
    - define loc <[trigger].below[1]>
    - random:
        - define material <material[red_concrete]>
        - define material <material[orange_concrete]>
        - define material <material[yellow_concrete]>
        - define material <material[lime_concrete]>
        - define material <material[light_blue_concrete]>
        - define material <material[pink_concrete]>
        - define material <material[purple_concrete]>
    - showfake <[material]> <[loc]> duration:5t players:<server.online_players>
    - foreach <[loc].points_around_y[radius=1;points=4]> as:loc:
        - random:
            - define material <material[red_concrete]>
            - define material <material[orange_concrete]>
            - define material <material[yellow_concrete]>
            - define material <material[lime_concrete]>
            - define material <material[light_blue_concrete]>
            - define material <material[pink_concrete]>
            - define material <material[purple_concrete]>
        - showfake <[material]> <[loc]> duration:5t players:<server.online_players>

nbf_util_labfloor:
    type: task
    definitions: trigger
    script:
    - ratelimit <player> 1t
    - define loc <[trigger].below[3]>
    - define material <material[sculk]>
    - showfake <[material]> <[loc]> duration:5s players:<server.online_players>
    - foreach <[loc].points_around_y[radius=1;points=4]> as:loc:
        - showfake <[material]> <[loc]> duration:5s players:<server.online_players>

nbf_util_endcrystalbeam:
    type: task
    definitions: player
    script:
    - repeat 10:
        - foreach <[player].location.find_entities[ender_crystal].within[64]> as:beam:
            - adjust <[beam]> beam_target:<[player].location.center.below[1.4]>

nbf_util_cloudtc:
    type: task
    definitions: trigger
    script:
    - ratelimit <player> 1t
    - define loc <[trigger].below[1]>
    - define material <material[purple_stained_glass]>
    - showfake <[material]> <[loc]> duration:2s players:<server.online_players>

nbf_util_fly:
    type: task
    definitions: player
    script:
    - ratelimit <player> 1m
    - execute as_server "fly <[player].name>"
    - narrate <element[<&gradient[from=#FD4945;to=#42FB42]>You now <&r><&gradient[from=#FD4945;to=#42FB42]>have flight <&r><&gradient[from=#FD4945;to=#42FB42]>mode on <&r><&gradient[from=#FD4945;to=#42FB42]>until you logout]> targets:<[player]>
