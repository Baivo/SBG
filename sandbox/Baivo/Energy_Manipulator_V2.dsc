# Author: Baivo
# You can ask a little
# 
# "The Magic plugin works fine!" 
#  and other hilarious jokes you can tell yourself

###############
#ITEM HANDLING#
###############
# Event for handling item interacts
item_interact_events:
    type: world
    debug: false
    events:
        on player right clicks block type:* with:item_flagged:emcaster:
            - determine cancelled passively
            - define item <context.item>
            - ratelimit <player> 5t
            - ~run <[item].flag[method]> def.caster:<player> def.caster_em:<[item]>
        on player left clicks block type:* with:item_flagged:emitem:
            - determine cancelled passively
            - ratelimit <player> 10t
            - run em_GUI_script def.caster_em:<context.item> def.caster:<player>
        on player places block using:off_hand:
            - if <player.item_in_hand.has_flag[emcaster]>:
                - determine cancelled passively
#BIVCO Energy manipulator Mk2 item
em2_item:
    type: item
    debug: false
    material: nether_star
    display name: <&[item]><dark_gray><bold>BIVCO<&sp><dark_purple><bold>EM-2
    lore:
    - <dark_gray><bold>BIVCO <dark_purple><bold>Executive Nano Division
    - <white>
    - <red>Left click <gray>to adjust function
    - <white>
    - <green>Right click <gray>to activate function
    mechanisms:
        unbreakable: true
        hides: all
        custom_model_data: 18001
    flags:
        # base
        emitem: true
        emcaster: true
        method: raycast
        function: cast_basic
        # Sounds
        sound_function: null
        sound_caster: null
        sound_target: null
        # Particles
        particle_function: null
        particle_caster: null
        particle_target: null
        # AoE/Range - AoE is area of effect at target, caster is area of effect around caster
        range_vector: null
        range_aoe: null
        range_caster: null
        # Effect Variables
        effect_damage: null
        effect_speed: null
        effect_duration: null
        effect_count: null
        effect_cooldown: null
        effect_cost: null
        # Function Variables
        function_entity: null
        function_block: null
        function_item: null
        function_caster: null
        function_creator: null
        function_special: null
##############
#GUI HANDLING#
##############
em_GUI_script:
    type: task
    definitions: caster_em|caster
    debug: false
    script:
    - ratelimit <[caster]> 10t
    - define inv <inventory[em_gui]>
    - define itemdata <[caster_em].flag_map.exclude[emitem|emcaster]>
    - foreach <[itemdata]> key:key:
        - inventory set d:<[inv]> slot:<[loop_index]> o:emicon
        - inventory adjust d:<[inv]> slot:<[loop_index]> display:<&a><[key]>
        - inventory adjust d:<[inv]> slot:<[loop_index]> lore:<&c><[value]>
        - inventory adjust d:<[inv]> slot:<[loop_index]> flag:param:<[key]>
        - inventory adjust d:<[inv]> slot:<[loop_index]> flag:paramvalue:<[value]>
        - inventory adjust d:<[inv]> slot:<[loop_index]> flag:emguiitem
        - define lastslot <[loop_index].add_int[1]>
    - inventory set d:<[inv]> slot:<[lastslot]> o:emoutput
    - inventory adjust d:<[inv]> slot:<[lastslot]> flag:emoutput
    - inventory open d:<[inv]>
#
em_gui:
  type: inventory
  inventory: chest
  title: <dark_green>Click to set active function
  size: 27
  gui: true
#
emicon:
    type: item
    material: stone
#
emoutput:
    type: item
    material: written_book
#
em_GUI_handler:
    type: world
    events:
        after player left clicks !air in em_gui:
        - if <context.item.has_flag[emguiitem]>:
            - define param <context.item.flag_map.get[param]>
            - define paramvalue <context.item.flag_map.get[paramvalue]>
            - narrate "<&7>Enter the new value:"
            - flag <player> emgui:<[param]>
            - inventory close
        - if <context.item.has_flag[emoutput]>:
            - narrate "<&7>Enter the spell name:"
            - flag <player> emoutput:true
            - inventory close

em_gui_chat_handler:
    type: world
    debug: false
    events:
        on player chats flagged:emgui:
            - define item <player.item_in_hand>
            - define valuemod <player.flag[emgui]>
            - narrate "<&c><[valuemod]><&7> updated to: <&e><context.message>"
            - inventory flag d:<player.inventory> slot:hand <[valuemod]>:<context.message>
            - flag <player> emgui:!
            - determine cancelled
        on player chats flagged:emoutput:
            - inventory set d:<player.inventory> slot:offhand o:<player.item_in_hand>
            - inventory adjust d:<player.inventory> slot:offhand material:paper
            - inventory flag d:<player.inventory> slot:offhand em:!
            - inventory adjust d:<player.inventory> slot:offhand custom_model_data:!
            - inventory adjust d:<player.inventory> slot:offhand display:<&a>Output
            - inventory adjust d:<player.inventory> slot:offhand lore:!
            - inventory adjust d:<player.inventory> slot:offhand flag:emitem:!
            - inventory adjust d:<player.inventory> slot:offhand display:<&a><context.message>
            - inventory adjust d:<player.inventory> slot:offhand lore:<&a>Created<&sp>by<&sp><player.nameplate>
            - flag <player> emoutput:!
            - determine cancelled
############################
    #CASTING METHODS#
############################
#
########### .if_null[10]
method_raycast:
    type: task
    debug: false
    definitions: caster|caster_em
    script:
    - define vector <[caster_em].flag[range_vector]>
    - define targetlocation <[caster].eye_location.ray_trace[return=precise;raysize=2;entities:*;range=<[vector]>;ignore=<[caster]>]>
    - define targetentity <[caster].precise_target[<[vector]>]>
    - if <[targetentity].is_living>:
        - define target <[targetentity].location>
    - else:
        - define target <[targetlocation]>
    - if <[caster_em].flag[particle_vector]> != null:
        - foreach <[caster].eye_location.points_between[<[targetlocation]>].distance[2]> as:ray:
            - playeffect at:<[ray]> effect:<[caster_em].flag[particle_function]> quantity:1 offset:0.1
    - if <[caster_em].flag[sound_caster]> != null:
        - playsound <[caster].location> sound:<[caster_em].flag[sound_caster]>
    - if <[caster_em].flag[sound_target]> != null:
        - playsound <[target].location> sound:<[caster_em].flag[sound_target]>
    - if <[caster_em].flag[particle_caster]> != null:
        - playeffect at:<[caster].location.above[1]> effect:<[caster_em].flag[particle_caster]> quantity:9 offset:1
    - if <[caster_em].flag[particle_target]> != null:
        - playeffect at:<[target].above[1]> effect:<[caster_em].flag[particle_target]> quantity:9 offset:1
    - foreach <list[<[caster_em].flag[function]>]> as:function:
        - ~run <[function]> def.targetentity:<[targetentity]> def.caster_em:<[caster_em]> def.caster:<[caster]> def.target:<[target]>

method_projectile:
    type: task
    debug: false
    definitions: caster|caster_em
    script:
    - define vector <[caster_em].flag[range_vector]>
    - if <[vector]> == null:
        - define vector 32
    - define targetlocation <[caster].eye_location.ray_trace[raysize=2.0;entities:*;range=<[vector]>;ignore=<[caster]>]>
    - define targetentity <[caster].precise_target[<[vector]>]>
    - if <[targetentity].is_living>:
        - define target <[targetentity].location>
    - else:
        - define target <[targetlocation]>
    - if <[caster_em].flag[sound_caster]> != null:
        - playsound <[caster].location> sound:<[caster_em].flag[sound_caster]>
    - if <[caster_em].flag[sound_target]> != null:
        - playsound <[target].location> sound:<[caster_em].flag[sound_target]>
    - if <[caster_em].flag[particle_caster]> != null:
        - playeffect at:<[caster].location.above[1]> effect:<[caster_em].flag[particle_caster]> quantity:9 offset:1
    - if <[caster_em].flag[particle_target]> != null:
        - playeffect at:<[target].above[1]> effect:<[caster_em].flag[particle_target]> quantity:9 offset:1
    - foreach <[caster].eye_location.points_between[<[target]>].distance[2]> as:path:
        - playeffect at:<[path]> effect:<[caster_em].flag[particle_function]> quantity:2 offset:0.2
        - wait 1t
    - foreach <list[<[caster_em].flag[function]>]> as:function:
        - ~run <[function]> def.targetentity:<[targetentity]> def.caster_em:<[caster_em]> def.caster:<[caster]> def.target:<[target]>


method_area_entity:
    type: task
    debug: false
    definitions: caster|caster_em
    script:
    - define area <[caster_em].flag[range_caster]>
    - define targetlist <[caster].location.find.living_entities.within[<[area]>]||null>
    - if <[targetlist].is_empty>:
        - playeffect at:<[caster].location> effect:smoke quantity:3 offset:1
        - playsound <[caster].location> sound:ENTITY_GENERIC_EXTINGUISH_FIRE
        - determine cancelled
    - else:
        - if <[caster_em].flag[sound_caster]> != null:
            - playsound <[caster].location> sound:<[caster_em].flag[sound_caster]>
        - if <[caster_em].flag[particle_caster]> != null:
            - playeffect at:<[caster].location.above[1]> effect:<[caster_em].flag[particle_caster]> quantity:9 offset:1
        - foreach <[targetlist]> as:targetentity:
            - if <[targetentity].is_player>:
                - foreach next
            - define target <[targetentity].location>
            - if <[caster_em].flag[sound_target]> != null:
                - playsound <[target].location> sound:<[caster_em].flag[sound_target]>
            - if <[caster_em].flag[particle_target]> != null:
                - playeffect at:<[target].above[1]> effect:<[caster_em].flag[particle_target]> quantity:9 offset:1
            - foreach <list[<[caster_em].flag[function]>]> as:function:
                - ~run <[function]> def.targetentity:<[targetentity]> def.caster_em:<[caster_em]> def.caster:<[caster]> def.target:<[target]>

method_area_block:
    type: task
    debug: true
    definitions: caster|caster_em
    script:
    - define area <[caster_em].flag[range_caster]>
    - define targetlist <[caster].location.find_blocks[!air].within[<[area]>]||null>
    - if <[targetlist].is_empty>:
        - playeffect at:<[caster].location> effect:smoke quantity:3 offset:1
        - playsound <[caster].location> sound:ENTITY_GENERIC_EXTINGUISH_FIRE
        - determine cancelled
    - else:
        - if <[caster_em].flag[sound_caster]> != null:
            - playsound <[caster].location> sound:<[caster_em].flag[sound_caster]>
        - if <[caster_em].flag[particle_caster]> != null:
            - playeffect at:<[caster].location.above[1]> effect:<[caster_em].flag[particle_caster]> quantity:9 offset:1
        - foreach <[targetlist]> as:targetblock:
            - if <[targetblock].material> == air:
                - foreach next
            - define target <[targetblock]>
            - if <[caster_em].flag[particle_target]> != null:
                - playeffect at:<[target].above[1]> effect:<[caster_em].flag[particle_target]> quantity:1 offset:1
            - foreach <list[<[caster_em].flag[function]>]> as:function:
                - ~run <[function]> def.targetblock:<[targetblock]> def.caster_em:<[caster_em]> def.caster:<[caster]> def.target:<[target]>

method_ray_block:
    type: task
    debug: true
    definitions: caster|caster_em
    script:
    - define vector <[caster_em].flag[range_vector]>
    - define target <[caster].eye_location.ray_trace[return=precise;raysize=2;entities:*;range=<[vector]>;ignore=<[caster]>]>
    - define area <[caster_em].flag[range_aoe].if_null[3]>
    - if <[caster_em].flag[particle_vector]> != null:
        - foreach <[caster].eye_location.points_between[<[target]>].distance[2]> as:ray:
            - playeffect at:<[ray]> effect:<[caster_em].flag[particle_function]> quantity:1 offset:0.1
    - if <[caster_em].flag[sound_target]> != null:
        - playsound <[target]> sound:<[caster_em].flag[sound_target]>
    - define targetlist <[target].find_blocks[!air].within[<[area]>]||null>
    - if <[caster_em].flag[sound_caster]> != null:
        - playsound <[caster].location> sound:<[caster_em].flag[sound_caster]>
    - if <[caster_em].flag[particle_caster]> != null:
        - playeffect at:<[caster].location.above[1]> effect:<[caster_em].flag[particle_caster]> quantity:9 offset:1
    - foreach <[targetlist]> as:targetblock:
        - if <[targetblock].material> == air:
            - foreach next
        - if <[caster_em].flag[particle_target]> != null:
            - playeffect at:<[targetblock].above[1]> effect:<[caster_em].flag[particle_target]> quantity:1 offset:1
        - foreach <list[<[caster_em].flag[function]>]> as:function:
            - ~run <[function]> def.targetblock:<[targetblock]> def.caster_em:<[caster_em]> def.caster:<[caster]> def.target:<[target]>

############################
    #CASTING FUNCTIONS#
############################
#
function_burn:
    type: task
    definitions: targetentity|target|caster|caster_em
    script:
        - if <[targetentity].is_living>:
            - burn <[targetentity]> duration:<[caster_em].flag[effect_duration]>
#
function_fakeitem:
    type: task
    definitions: targetentity|target|caster|caster_em
    script:
    - displayitem <[caster_em].flag[function_item]> <[target]> duration:<[caster_em].flag[effect_duration]>
#
function_blockswap:
    type: task
    definitions: targetblock|target|caster|caster_em
    script:
        - if <[caster].item_in_offhand.material> == <material[air]>:
            - determine cancelled
        - else:
            - showfake <[caster].item_in_offhand.material> <[targetblock]> d:<[caster_em].flag[effect_duration]> players:<server.online_players>.
            - run util_noclip def:caster:<[caster]>
#
util_noclip:
    type: task
    definitions: targetblock|target|caster|caster_em
    script:
        - adjust <[caster]> noclip:true
        - foreach <[caster].find_players_within[128]> as:player:
            - adjust <[player]> noclip:true
            - wait 10s
            - adjust <[player]> noclip:false
        - adjust <[caster]> noclip:false
#
function_blockwave:
    type: task
    definitions: targetblock|target|caster|caster_em
    script:
        - fakespawn falling_block[fallingblock_type=<[targetblock].material>] <[targetblock].above[1]> players:<server.online_players> d:5s save:block
        - showfake air <[targetblock]> players:<server.online_players> d:5s
        - define block <entry[block].faked_entity>
        - shoot <[block]> origin:<[block].location> destination:<[block].location.face[<[caster].location>].backward[<[caster_em].flag[effect_speed].mul[2]>]>
#
function_realblockwave:
    type: task
    definitions: targetblock|target|caster|caster_em
    script:
        - if <[caster_em].flag[method]> == method_ray_block:
            - define centre <[target]>
        - else if <[caster_em].flag[method]> == method_area_block:
            - define centre <[caster].location>
        - spawn falling_block[fallingblock_type=<[targetblock].material>] <[targetblock].above[1]> save:block
        - adjust <[targetblock]> coreprotect_log_removal:[user=<[caster].nameplate>;material=<[targetblock].material.name>]
        - modifyblock <[targetblock]> air
        - define block <entry[block].spawned_entity>
        - define material <[targetblock].material>
        - flag <[block]> emblock:<[caster].nameplate>
        - define logtype placement
        - shoot <[block]> origin:<[block].location> destination:<[block].location.face[<[centre]>].backward[<[caster_em].flag[effect_speed].mul[2]>]>
#
logblock:
    type: world
    events:
        after block falls:
            - if <context.entity.has_flag[emblock]>:
                - adjust <context.location> coreprotect_log_placement:[user=<context.entity.flag[emblock]>;material=<context.new_material.name>]
# script_logblock:
#     type: task
#     definitions: material|location|caster|logtype
#     script:
#         - if <[logtype]> = removal:
#             - adjust <[location]> coreprotect_log_removal:[user=<[caster].nameplate>;material=<[material].name>]
#         - if <[logtype]> = placement:
#             - adjust <[location]> coreprotect_log_placement:[user=<[caster].nameplate>;material=<[material].name>]
#
function_debugblock:
    type: task
    definitions: targetblock|target|caster|caster_em
    script:
        - debugblock <[targetblock]> d:<[caster_em].flag[effect_duration]> players:<server.online_players> color:<[caster_em].flag[function_special]>
#
function_entity_target:
        type: task
        definitions: targetentity|target|caster|caster_em
        script:
        - define entity <[caster_em].flag[function_entity]>
        - shoot <[entity]> destination:<[targetentity].location.above[1]> speed:<[caster_em].flag[effect_speed]>

function_spit:
        type: task
        definitions: targetentity|target|caster|caster_em
        script:
        - shoot <entity[llama_spit]> destination:<[targetentity].location> speed:<[caster_em].flag[effect_speed]>
#
function_entity:
    type: task
    debug: false
    definitions: targetentity|target|caster|caster_em
    script:
        - define entity <[caster_em].flag[function_entity]>
        - shoot <[entity].repeat_as_list[20]> speed:<[caster_em].flag[effect_speed]> spread:20
#
function_basic:
    type: task
    definitions: targetentity|target|caster|caster_em
    script:
        - if <[targetentity].is_living>:
            - hurt <[caster_em].flag[effect_damage]> <[targetentity]> source:<[caster]> cause:ENTITY_DAMAGE
#
function_push:
    type: task
    definitions: targetentity|target|caster|caster_em
    script:
        - shoot <[targetentity]> origin:<[targetentity].location> destination:<[targetentity].location.face[<[caster].location>].backward[<[caster_em].flag[effect_damage].mul[2]>]>
        - playeffect at:<[targetentity].location.above[1]> effect:<[caster_em].flag[particle_target]> quantity:3 offset:0.1
        - playsound <[caster].location> sound:<[caster_em].flag[caster_sound]> volume:0.5
        - playsound <[targetentity].location> sound:<[caster_em].flag[target_sound]> volume:0.5
#
function_pull:
    type: task
    definitions: targetentity|target|caster|caster_em
    script:
        - shoot <[targetentity]> origin:<[targetentity].location> destination:<[caster].location> speed:<[caster_em].flag[effect_damage]>
        - playeffect at:<[targetentity].location.above[1]> effect:<[caster_em].flag[particle_target]> quantity:3 offset:0.1
        - playsound <[caster].location> sound:<[caster_em].flag[caster_sound]> volume:0.5
        - playsound <[targetentity].location> sound:<[caster_em].flag[target_sound]> volume:0.5
#
function_frenzy:
    type: task
    definitions: targetentity|target|caster|caster_em
    script:
        - attack <[targetentity]> target:<[targetentity].location.find.living_entities.within[8].random>
        - playeffect at:<[targetentity].location.above[1.5]> effect:villager_angry quantity:3 offset:0.2
#
function_explode:
    type: task
    definitions: targetentity|target|caster|caster_em
    script:
        - explode power:<[caster_em].flag[effect_damage]> <[target]> source:<player>
#
function_explode_breakblocks:
    type: task
    definitions: targetentity|target|caster|caster_em
    script:
        - explode power:<[caster_em].flag[effect_damage]> <[target]> source:<player> breakblocks
#
function_leash:
    type: task
    definitions: targetentity|target|caster|caster_em
    script:
        - leash <[targetentity]> holder:<[caster]>
