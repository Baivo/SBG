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

nbf_util_pylonpath:
  type: task
  debug: false
  definitions: player|netblock
  script:
    - ratelimit <[player]> 10t
    - playeffect at:<[player].location> effect:portal_travel quantity:5 offset:1
  
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
    - playsound <[player].location> <[player]> sound:custom:amogus custom volume:0.2
    - define number <util.random.int[1].to[999]>
    - random:
      - define message "<player.nameplate> was detected in a restricted area."
      - define message "<player.nameplate> attempted to enter a restricted area without clearance. This attempt was stopped by <[number]> high calibre rounds."
      - define message "<player.nameplate> has been voluntarily enrolled into the BIVCO organ donation program."
      - define message "<player.nameplate> encountered the consequences of their own actions."

nbfe_util_lazergrid:
  type: world
  events:
    on player dies:
      - if <player.has_flag[nbfence]>:
        - determine passively NO_MESSAGE
        - announce "<player.nameplate> attempted to enter a restricted area"

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
        - define material <material[white_concrete]>
        # add more!
    - showfake <[material]> <[loc]> duration:3s players:<server.online_players>

nbf_util_endcrystalbeam:
    type: task
    definitions: player
    script:
    - repeat 10:
        - foreach <[player].location.find_entities[ender_crystal].within[64]> as:beam:
            - adjust <[beam]> beam_target:<[player].location.center.below[1.4]>
