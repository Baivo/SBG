# Author: Baivo
# Don't even ask
# 
# "The Magic plugin works fine!" 
#  and other hilarious jokes you can tell yourself
############################
    #CORE LOGIC TASKS#
############################
#Event for handling usage of casting items.
castitem_event:
    type: world
    debug: true
    events:
        on player right clicks block type:* with:item_flagged:em1use:
            - determine cancelled passively
            # - ratelimit <player> 1t
            - define functiondata <context.item.flag[functiondata].get[params]>
            - define function <[functiondata].get[fire_type]>
            - ~run <[function]> def.caster:<player> def.params:<context.item.flag_map[params]>
        on player left clicks block type:* with:item_flagged:em1:
            - determine cancelled passively
            - ratelimit <player> 1t
            - if <context.item.has_flag[em1]>:
                - run em1_GUI_script def.caster:<context.item>
#base map of data for all functions and items
functionbaseparams:
    type: data
    params:
        ray_particle: flame
        caster_particle: flame
        target_particle: flame
        caster_sound: entity_generic_extinguish_fire
        target_sound: entity_generic_extinguish_fire
        vector_range: 32
        area_radius: 1
        area_duration: 1
        effect_duration: 1
        effect_damage: 4
        cooldown: 1s
        entity: fireball
        effect_type: cast_fire
        fire_type: utilray
#
utilray:
    type: task
    debug: false
    definitions: caster
    script:
        - define functiondata <[caster].item_in_hand.flag[functiondata].get[params]>
        - define target <[caster].eye_location.ray_trace[entities:*;nonsolids=false;raysize=2;range=<[functiondata].get[vecor_range]>]||null>
        - define targetentity <[target].find.living_entities.within[3].first||null>
        - define function <[caster].item_in_hand.flag[function]>
        - define effect_type <[functiondata].get[effect_type]>
            #Draws a line from the caster to the target location and plays a particle effect every x block
        - foreach <[caster].eye_location.points_between[<[target]>].distance[2]> as:ray:
            - playeffect at:<[ray]> effect:<[functiondata].get[ray_particle]> quantity:1 offset:0.1
        #Play sounds and particle effects at the caster and target
        - playsound <[caster].location> sound:<[functiondata].get[caster_sound]> volume:0.5
        - playeffect at:<[target].above[2]> effect:<[functiondata].get[target_particle]> quantity:15 offset:1
        #If the raycast found a valid target, run the following logic.
        - ~run <[effect_type]> def.targetentity:<[targetentity]> def.functiondata:<[functiondata]> def.caster:<[caster]>

utilarea:
    type: task
    debug: true
    definitions: caster
    script:
        - define functiondata <[caster].item_in_hand.flag[functiondata].get[params]>
        - define target <[caster].eye_location||null>
        - define targetlist <[target].find.living_entities.within[<[functiondata].get[area_radius]>]||null>
        - define effect_type <[functiondata].get[effect_type]>
        - if <[targetlist].first> != null:
            - foreach <[targetlist]> as:targetentity:
                - ~run <[effect_type]> def.targetentity:<[targetentity]> def.functiondata:<[functiondata]> def.caster:<[caster]>

utiltemp:
    type: task
    debug: true
    definitions: caster
    script:
        - define functiondata <[caster].item_in_hand.flag[functiondata].get[params]>
        - define target <[caster].eye_location||null>
        - define targetlist <[target].find.living_entities.within[<[functiondata].get[area_radius]>]||null>
        - define effect_type <[functiondata].get[effect_type]>
        - if <[targetlist].first> != null:
            - foreach <[targetlist]> as:targetentity:
                - ~run <[effect_type]> def.targetentity:<[targetentity]> def.functiondata:<[functiondata]> def.caster:<[caster]>

utilorbital:
    type: task
    definitions: caster
    script:
        - define functiondata <[caster].item_in_hand.flag[functiondata].get[params]>
        - define target <[caster].eye_location.ray_trace[entities:*;nonsolids=false;raysize=2;range=<[functiondata].get[vecor_range]>]||null>
        - define effect_type <[functiondata].get[effect_type]>
        - define radius <[functiondata].get[area_radius]>
        - define points 180
        - define particle <[functiondata].get[caster_particle]>
        - repeat 6:
            - define ring <[target].points_around_y[points=<[points]>;radius=<[radius]>]>
            - foreach <[ring]> as:point:
                # - announce to_flagged:Baivo <[point]>
                - playeffect at:<[point]> effect:<[particle]> quantity:1 offset:0.0
            - define radius:-:<[radius].div[3]>
            - define points:-:<[points].div[23]>
            - wait 10t
        - foreach <[target].points_between[<[target].above[200]>].distance[0.2]> as:beam:
            - playeffect at:<[beam]> effect:<[functiondata].get[target_particle]> quantity:1 offset:0.0
        - run <[effect_type]> def.functiondata:<[functiondata]> def.caster:<[caster]> def.target:<[target]>


utilprojectile:
    type: task
    debug: false
    definitions: caster
    script:
        - define functiondata <[caster].item_in_hand.flag[functiondata].get[params]>
        - define effect_type <[functiondata].get[effect_type]>
        - define entity <[functiondata].get[entity]>
        - playsound <[caster].location> sound:<[functiondata].get[caster_sound]> volume:0.5
        - shoot <[entity]> speed:<[functiondata].get[effect_damage]> script:<[effect_type]>

utilrayarea:
    type: task
    debug: false
    definitions: caster
    script:
        - define functiondata <[caster].item_in_hand.flag[functiondata].get[params]>
        - define target <[caster].eye_location.ray_trace[entities:*;nonsolids=false;raysize=2;range=<[functiondata].get[vecor_range]>]||null>
        - define targetlist <[target].find.living_entities.within[<[functiondata].get[area_radius]>]||null>
        - define effect_type <[functiondata].get[effect_type]>
            #Draws a line from the caster to the target location and plays a particle effect every x block
        - foreach <[caster].eye_location.points_between[<[target]>].distance[2]> as:ray:
            - playeffect at:<[ray]> effect:<[functiondata].get[ray_particle]> quantity:1 offset:0.1
        #Play sounds and particle effects at the caster and target
        - playsound <[caster].location> sound:<[functiondata].get[caster_sound]> volume:0.5
        - playeffect at:<[target].above[2]> effect:<[functiondata].get[target_particle]> quantity:15 offset:1
        #If the raycast found a valid target, run the following logic.
        - if <[targetlist].first> != null:
            - foreach <[targetlist]> as:targetentity:
                - ~run <[effect_type]> def.targetentity:<[targetentity]> def.functiondata:<[functiondata]> def.caster:<[caster]>

utilaimbot:
    type: task
    debug: false
    definitions: caster
    script:
        - define functiondata <[caster].item_in_hand.flag[functiondata].get[params]>
        - define target <[caster].eye_location.ray_trace[entities:*;nonsolids=false;raysize=4;range=<[functiondata].get[vecor_range]>]||null>
        - define targetentity <[target].find.living_entities.within[5].first||null>
        - if <[targetentity]> != null:
            - define target <[targetentity]>
        - define function <[caster].item_in_hand.flag[function]>
        - define effect_type <[functiondata].get[effect_type]>
        #Play sounds and particle effects at the caster and target
        - playsound <[caster].location> sound:<[functiondata].get[caster_sound]> volume:0.5
        - playeffect at:<[target].above[1]> effect:<[functiondata].get[target_particle]> quantity:15 offset:1
        #If the raycast found a valid target, run the following logic.
        - announce to_flagged:Baivo "The target is <[target]>, the target entity is <[targetentity]>"
        - ~run <[effect_type]> def.target:<[target]> def.functiondata:<[functiondata]> def.caster:<[caster]>
#
############################
    #CASTING ITEMS#
############################
##
#BIVCO Energy manipulator Mk1 item
em1_item:
    type: item
    debug: false
    material: nether_star
    display name: <&[item]><dark_gray><bold>BIVCO<&sp><dark_purple><bold>EM-1
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
        em1: true
        em1use: true
        function: utilray
        functiondata:
            params:
                ray_particle: flame
                caster_particle: flame
                target_particle: flame
                caster_sound: entity_generic_extinguish_fire
                target_sound: entity_generic_extinguish_fire
                vector_range: 32
                area_radius: 5
                area_duration: 1
                effect_duration: 1
                effect_damage: 8
                cooldown: 1s
                entity: fireball
                effect_type: cast_push
                fire_type: utilarea
####
##
em1_GUI_script:
    type: task
    definitions: caster
    debug: false
    script:
    - ratelimit <player> 10t
    - define functiondata <[caster].flag[functiondata].get[params]>
    - define inv <inventory[em1_gui]>
    - foreach <[functiondata]> key:key:
        - inventory set d:<[inv]> slot:<[loop_index]> o:em1icon
        - inventory adjust d:<[inv]> slot:<[loop_index]> display:<&a><[key]>
        - inventory adjust d:<[inv]> slot:<[loop_index]> lore:<&c><[value]>
        - inventory adjust d:<[inv]> slot:<[loop_index]> flag:param:<[key]>
        - inventory adjust d:<[inv]> slot:<[loop_index]> flag:paramvalue:<[value]>
        - inventory adjust d:<[inv]> slot:<[loop_index]> flag:em1guiitem
        - if <[loop_index]> == 4 || <[loop_index]> == 5:
            - inventory adjust d:<[inv]> slot:<[loop_index]> flag:em1soundguiitem
            - inventory adjust d:<[inv]> slot:<[loop_index]> flag:em1guiitem:!
        - define lastslot <[loop_index].add_int[1]>
    - inventory set d:<[inv]> slot:<[lastslot]> o:em1output
    - inventory adjust d:<[inv]> slot:<[lastslot]> flag:em1output
    - inventory open d:<[inv]>
##
em1_gui:
  type: inventory
  inventory: chest
  title: <dark_green>Click to set active function
  size: 18
  gui: true

em1icon:
    type: item
    material: stone

em1output:
    type: item
    material: written_book
##
em1_GUI_handler:
    type: world
    events:
        after player left clicks !air in em1_gui:
        - if <context.item.has_flag[em1guiitem]>:
            - define param <context.item.flag_map.get[param]>
            - define paramvalue <context.item.flag_map.get[paramvalue]>
            # - inventory adjust slot:hand flag:spell:<[spell]>
            - narrate "<&7>Enter the new value:"
            - flag <player> emgui:<[param]>
            - inventory close
        - if <context.item.has_flag[em1output]>:
            - narrate "<&7>Enter the spell name:"
            - flag <player> em1output:true
            - inventory close
        - if <context.item.has_flag[em1soundguiitem]>:
            - define param <context.item.flag_map.get[param]>
            - define paramvalue <context.item.flag_map.get[paramvalue]>
            - narrate "<&7>Enter the sound name, or say 'soundmenu' to open a sound menu:"
            - flag <player> emgui:<[param]>
            - inventory close
        after player left clicks !air in em1_sound_gui:
        - if <context.item.has_flag[em1sound]>:
            - define sound <context.item.flag_map.get[sound]>
            - define param <context.item.flag_map.get[param]>
            - inventory flag d:<player.inventory> slot:hand functiondata.params.<[param]>:<[sound]>
            - inventory close

em1_gui_chat_handler:
    type: world
    debug: true
    events:
        on player chats flagged:emgui:
            - if <context.message> == soundmenu:
                - run em1_sound_GUI_script def.param:<player.flag[param]>
                - flag <player> emgui:!
                - determine cancelled
                - stop
            - else:
                - definemap functiondata:
                    params: <player.item_in_hand.flag[functiondata].get[params]>
                - define valuemod <player.flag[emgui]>
                - foreach <[functiondata.params]> key:key:
                    - if <[key]> != <[valuemod]>:
                        - foreach next
                    - else:
                        - narrate "<&c><[key]><&7> updated to: <&e><context.message>"
                        - inventory flag d:<player.inventory> slot:hand functiondata.params.<[key]>:<context.message>
                - flag <player> emgui:!
                - determine cancelled
        on player chats flagged:em1output:
            - inventory set d:<player.inventory> slot:offhand o:<player.item_in_hand>
            - inventory adjust d:<player.inventory> slot:offhand material:paper
            - inventory flag d:<player.inventory> slot:offhand em1:!
            - inventory adjust d:<player.inventory> slot:offhand custom_model_data:!
            - inventory adjust d:<player.inventory> slot:offhand display:<&a>Output
            - inventory adjust d:<player.inventory> slot:offhand lore:!
            - inventory adjust d:<player.inventory> slot:offhand display:<&a><context.message>
            - inventory adjust d:<player.inventory> slot:offhand lore:<&a>Created<&sp>by<&sp><player.nameplate>
            - flag <player> em1output:!
            - determine cancelled
##
em1_sound_gui:
  type: inventory
  inventory: chest
  title: <dark_green>Click to set sound
  size: 54
  gui: true

em1_sound_GUI_script:
    type: task
    definitions: caster|param
    debug: false
    script:
    - ratelimit <player> 10t
    - define soundlist <server.sound_types>
    - define inv <inventory[em1_sound_gui]>
    - foreach <[soundlist]> key:key:
        - if <[loop_index]> <= 53:
            - inventory set d:<[inv]> slot:<[loop_index]> o:em1icon
            - inventory adjust d:<[inv]> slot:<[loop_index]> display:<&a><[value]>
            - inventory adjust d:<[inv]> slot:<[loop_index]> lore:<&sp>
            - inventory adjust d:<[inv]> slot:<[loop_index]> flag:sound:<[value]>
            - inventory adjust d:<[inv]> slot:<[loop_index]> flag:param:<[param]>
            - inventory adjust d:<[inv]> slot:<[loop_index]> flag:em1sound
        - else:
            - foreach stop
        - define lastslot <[loop_index].add_int[1]>
    - inventory set d:<[inv]> slot:<[lastslot]> o:em1output
    - inventory adjust d:<[inv]> slot:<[lastslot]> flag:em1output
    - inventory open d:<[inv]>
############################
    #CASTING LOGIC#
############################
##
cast_effect_list:
    type: data
    effect_list:
    - cast_fire
    - cast_basic
    - cast_push

cast_fire:
    type: task
    definitions: targetentity|functiondata
    script:
        - burn <[targetentity]> duration:<[functiondata].get[effect_duration]>

cast_entity_target:
        type: task
        definitions: targetentity|functiondata|caster
        script:
        - define entity <[functiondata].get[entity]>
        - shoot <[entity]> destination:<[targetentity].location.above[1]> speed:<[functiondata].get[effect_damage]>

cast_entity:
    type: task
    debug: false
    definitions: targetentity|functiondata|caster
    script:
        - define entity <[functiondata].get[entity]>
        - shoot <[entity]> speed:<[functiondata].get[effect_damage]>

cast_basic:
    type: task
    definitions: targetentity|functiondata|caster
    script:
        - hurt <[functiondata].get[effect_damage]> <[targetentity]> source:<[caster]> cause:ENTITY_DAMAGE

cast_push:
    type: task
    definitions: targetentity|functiondata|caster
    script:
        - shoot <[targetentity]> origin:<[targetentity].location> destination:<[targetentity].location.face[<[caster].location>].backward[<[functiondata].get[effect_damage].mul[2]>]>
        - playeffect at:<[targetentity].location.above[1]> effect:<[functiondata].get[target_particle]> quantity:3 offset:0.1
        - playsound <[caster].location> sound:<[functiondata].get[caster_sound]> volume:0.5
        - playsound <[targetentity].location> sound:<[functiondata].get[target_sound]> volume:0.5

cast_frenzy:
    type: task
    definitions: targetentity|functiondata|caster
    script:
        - attack <[targetentity]> target:<[targetentity].location.find.living_entities.within[8].random>
        - playeffect at:<[targetentity].location.above[1.5]> effect:villager_angry quantity:3 offset:0.2

cast_explode:
    type: task
    definitions: location
    script:
        - define functiondata <player.item_in_hand.flag[functiondata].get[params]>
        - explode power:<[functiondata].get[area_radius]> <[location]> source:<player>

cast_explode_breakblocks:
    type: task
    definitions: location
    script:
        - define functiondata <player.item_in_hand.flag[functiondata].get[params]>
        - explode power:<[functiondata].get[area_radius]> <[location]> source:<player> breakblocks



###DEFUNCT OLD PEW
# simpleray:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - foreach <[caster].eye_location.points_between[<[target]>].distance[1]> as:ray:
#             - playeffect at:<[ray]> effect:wax_off quantity:1 offset:0.1
#         - playsound <[caster].location> sound:entity_evoker_cast_spell volume:0.5
#         - playeffect at:<[target].above[0.6]> effect:dragon_breath quantity:15 offset:1
#         - if <[targetentity]> != null:
#             - hurt 20 <[targetentity]> source:<[caster]>

# simpleray_item:
#     type: item
#     debug: false
#     material: amethyst_shard
#     display name: <&[item]><&b><bold>Ray Gun
#     lore:
#     - <gray>Shoots Ray
#     - <white>
#     - <gray>(R.I.P Ray 2022-2022)
#     mechanisms:
#         unbreakable: true
#         hides: all

# shrink:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - foreach <[caster].eye_location.points_between[<[target]>].distance[1]> as:ray:
#             - playeffect at:<[ray]> effect:wax_off quantity:1 offset:0.1
#         - playsound <[caster].location> sound:entity_evoker_cast_spell volume:0.5
#         - playeffect at:<[target].above[0.6]> effect:villager_happy quantity:15 offset:1
#         - if <[targetentity]> != null:
#             - age <[targetentity]> baby

# shrink_item:
#     type: item
#     debug: false
#     material: clock
#     display name: <&[item]><&b><bold>Entity Shrink
#     lore:
#     - <gold>♫ Y'all just halfway thoughts ♫
#     - <gray>♫ Not worth the back of my mind ♫
#     - <gold>♫ But to understand the future ♫
#     - <gray>♫ We have to go back in time ♫
#     - <light_purple>✦ Baby, ✦ oh, ✦ baby✦
#     mechanisms:
#         unbreakable: true
#         hides: all

# frenzy:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - foreach <[caster].eye_location.points_between[<[target]>].distance[1]> as:ray:
#             - playeffect at:<[ray]> effect:wax_off quantity:1 offset:0.1
#         - playsound <[caster].location> sound:entity_evoker_cast_spell volume:0.5
#         - playeffect at:<[target].above[0.6]> effect:villager_angry quantity:15 offset:1
#         - if <[targetentity]> != null:
#             - define frenzylist <[targetentity].location.find.living_entities.within[6]||null>
#             - foreach <[frenzylist]> as:frenzy:
#                 - attack <[frenzy]> target:<[frenzy].location.find.living_entities.within[8].random>
#                 - playeffect at:<[frenzy].location.above[1.5]> effect:villager_angry quantity:3 offset:0.2
# frenzy_item:
#     type: item
#     debug: false
#     material: observer
#     display name: <&[item]><&b><bold>Frenzy
#     lore:
#     - <gray><element[☹☹☹☹☹☹☹☹☹☹☹].color_gradient[from=#e06a02;to=#c99804]>
#     - <white>
#     - <gray><element[☹☹☹☹☹☹☹☹☹☹☹].color_gradient[from=#e06a02;to=#c99804]>
#     mechanisms:
#         unbreakable: true
#         hides: all

# ignite:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - foreach <[caster].eye_location.points_between[<[target]>].distance[1]> as:ray:
#             - playeffect at:<[ray]> effect:flame quantity:1 offset:0.1
#         - playsound <[caster].location> sound:entity_ghast_shoot volume:1
#         - if <[targetentity]> != null:
#             - define targetlist <[targetentity].location.find.living_entities.within[3]||null>
#             - foreach <[targetlist]> as:ignite:
#                 - burn <[ignite]> duration:6
#                 - playeffect at:<[ignite].location.above[1.5]> effect:flame quantity:5 offset:0.2

# ignite_item:
#     type: item
#     debug: false
#     material: blaze_powder
#     display name: <&[item]><red><bold>Ignite
#     lore:
#     - <gray>Ignites entities in a radius at the target
#     - <white>
#     - <gray>Range 200|Radius 3
#     mechanisms:
#         unbreakable: true
#         hides: all

# targetleash:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - playsound <[caster].location> sound:entity_leash_knot_place volume:1
#         - define targetlist <[caster].location.find.living_entities.within[5]||null>
#         - foreach <[targetlist]> as:targetleash:
#             - leash <[targetleash]> holder:<[caster]>

# targetleash_item:
#     type: item
#     debug: false
#     material: lead
#     display name: <&[item]><&b><bold>Mass Leash
#     lore:
#     - <gray>Leashes entities in a radius
#     - <white>
#     - <gray>Radius: 5
#     mechanisms:
#         unbreakable: true
#         hides: all

# fishgun:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - repeat 20:
#             - define fish <list[frog]>
#             - shoot <[fish].random> origin:<[caster]> destination:<[target]> speed:6 spread:4.0

# fishgun_item:
#     type: item
#     debug: false
#     material: pufferfish
#     display name: <&[item]><&a><bold>Fish Gun
#     lore:
#     - <gray>Shoots fish
#     - <white>
#     - <gray>fish
#     mechanisms:
#         unbreakable: true
#         hides: all

# pushaway:
#     type: task
#     debug: true
#     definitions: caster|target|targetentity
#     script:
#         - define targetlist <empty>
#         - foreach <[caster].eye_location.points_between[<[target]>].distance[2]> as:ray:
#             - playeffect at:<[ray]> effect:cloud quantity:1 offset:1
#             - define found <[ray].find.living_entities.within[3]>
#             - define targetlist <list[<[targetlist]>|<[found]>].combine>
#             - define targetlist <[targetlist].exclude[<player>]>
#             - define targetlist <[targetlist].deduplicate>
#             # - define targetlist <[targetlist].deduplicate>
#         - playsound <[caster].location> sound:entity_blaze_shoot volume:1
#         - foreach <[targetlist]> as:targetleash:
#             - if <[targetleash].entity_type> != ARMOR_STAND:
#                 - shoot <[targetleash]> origin:<[targetleash].location> destination:<[targetleash].location.face[<[caster].location>].backward[20]>
#                 - playeffect at:<[targetleash].location.above[1.5]> effect:cloud quantity:3 offset:0.2

# pushaway_item:
#     type: item
#     debug: false
#     material: phantom_membrane
#     display name: <&[item]><gray><bold>Push
#     lore:
#     - <gray>Push things away
#     - <white>
#     - <gray>Push Real Far!
#     mechanisms:
#         unbreakable: true
#         hides: all

# animatedev:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - define radius 1
#         - define points 12
#         - repeat 20:
#             - define ring <[caster].location.points_around_y[points=<[points]>;radius=<[radius]>]>
#             - playeffect at:<[ring]> effect:dripping_obsidian_tear quantity:4 offset:10
#             - define radius:+:<[radius].mul[0.3]>
#             - define points:+:<[points].mul[0.4]>
#             - wait 2t

# animatedev_item:
#     type: item
#     debug: false
#     material: stone
#     display name: <&[item]><&b><bold>dev-animate
#     lore:
#     - <gray>Ldev
#     - <white>
#     - <gray>Radius: 5
#     mechanisms:
#         unbreakable: true
#         hides: all

# personeldev:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - define blocks <player[ShiftyThrifty12].location.find_blocks[air].within[3]>
#         - teleport <player[Baivo]> <[blocks].random.face[<player[TinkTheTank].location>]>

# personeldev_item:
#     type: item
#     debug: false
#     material: stone
#     display name: <&[item]><&b><bold>dev-personel
#     lore:
#     - <gray>Ldev
#     - <white>
#     - <gray>Radius: 5
#     mechanisms:
#         unbreakable: true
#         hides: all

# tntcannon:
#     type: task
#     debug: true
#     definitions: caster|target|targetentity
#     script:
#         - shoot PRIMED_TNT|PRIMED_TNT|PRIMED_TNT|PRIMED_TNT|PRIMED_TNT origin:<[caster].location> destination:<[caster].cursor_on_solid>

# tntcannon_item:
#     type: item
#     debug: false
#     material: tnt
#     display name: <&[item]><red><bold>TNT Cannon
#     lore:
#     - <red>Spy, why did you draw yourself
#     - <red>as a buff two-legged wolf person?
#     - <gray><italic>Thats... my fursona...
#     - <red>Your fucking what?
#     - <gray><italic>HIS NAME IS DUTCH. HE'S MY FURSONA
#     - <gray><italic>I roleplay as a soft shy-wolf on twitter...
#     mechanisms:
#         unbreakable: true
#         hides: all


# ####wand

# wand_item:
#     type: item
#     debug: false
#     material: nether_star
#     display name: <&[item]><dark_gray><bold>BIVCO<&sp><dark_purple><bold>EM-1
#     lore:
#     - <dark_gray><bold>BIVCO <dark_purple><bold>Executive Nano Division
#     - <white>
#     - <red>Left click <gray>to adjust function
#     - <white>
#     - <green>Right click <gray>to activate function
#     mechanisms:
#         unbreakable: true
#         hides: all
#         custom_model_data: 18001
#     flags:
#         wand: true
#         spell: none

# wand_item_handler:
#   type: world
#   debug: false
#   events:
#     after player left clicks block with:item_flagged:wand:
#     - run wand_GUI_script
#     - determine cancelled passively

# wand_GUI_script:
#     type: task
#     script:
#     - ratelimit <player> 10t
#     - define wandlist <map[1=fishgun_item;2=simpleray_item;3=shrink_item;4=frenzy_item;5=ignite_item;6=targetleash_item;7=pushaway_item;8=animatedev_item;9=tntcannon_item]>
#     - define inv <inventory[wand_gui]>
#     - foreach <[wandlist]>:
#         - inventory set d:<[inv]> slot:<[key]> o:<[value]>
#         - inventory adjust d:<[inv]> slot:<[key]> flag:spellguiitem
#     - inventory open d:<[inv]>

# wand_gui:
#   type: inventory
#   inventory: chest
#   title: <dark_green>AHHHHH
#   size: 9
#   gui: true

# wand_GUI_handler:
#     type: world
#     events:
#         after player left clicks !air in wand_gui:
#         - if <context.item.has_flag[spellguiitem]>:
#             - define spell <item[<context.item>].script.name.replace[_item]>
#             - inventory adjust slot:hand flag:spell:<[spell]>
#             - narrate "<&7>You have chosen: <item[<context.item>].display>"

# wand:
#     type: world
#     debug: false
#     events:
#         on player right clicks block type:* with:wand_item:
#             - determine cancelled passively
#             - ratelimit <player> 1t
#             - define caster <player>
#             - define target <player.eye_location.ray_trace[entities:*;raysize=2;range=50]||null>
#             - define entityfind <[target].find.living_entities.within[1.5]||null>
#             - define targetentity <[entityfind].get[1]||null>
#             - define spell <player.item_in_hand.flag[spell]>
#             - run <player.item_in_hand.flag[spell]> def.caster:<[caster]> def.target:<[target]> def.targetentity:<[targetentity]>

# bivparticle:
#     type: task
#     definitions: player
#     script:
#         - define target <[player].location>
#         - define radius 1
#         - define points 20
#         - define ascend 0
#         - define ring <[target].points_around_y[points=<[points]>;radius=<[radius]>]>
#         - foreach <[ring]> as:point:
#             - playeffect at:<[point].above[<[ascend]>]> effect:glow quantity:1 offset:0.0
#             - define ascend:+:0.1
#         - foreach <[ring]> as:point:
#             - playeffect at:<[point].above[<[ascend]>]> effect:glow quantity:1 offset:0.0
#             - define ascend:-:0.1

# bivparticlerun:
#     type: world
#     events:
#         on delta time secondly:
#         - foreach <server.online_players_flagged[Baivo]> as:player:
#             - run bivparticle def.player:<[player]>

scorched_earth:
    type: task
    definitions: caster
    script:
        - define functiondata <[caster].item_in_hand.flag[functiondata].get[params]>
        - define target <[caster].eye_location.ray_trace[entities:*;nonsolids=false;raysize=2;range=<[functiondata].get[vecor_range]>]||null>
        - define effect_type <[functiondata].get[effect_type]>
        - define radius <[functiondata].get[area_radius]>
        - define points 360
        - define particle <[functiondata].get[caster_particle]>
        - repeat 10:
            - define ring <[target].points_around_y[points=<[points]>;radius=<[radius]>]>
            - foreach <[ring]> as:point:
                # - announce to_flagged:Baivo <[point]>
                - playeffect at:<[point]> effect:<[particle]> quantity:1 offset:0.0
                - run <[effect_type]> def.functiondata:<[functiondata]> def.caster:<[caster]> def.target:<[point]>
                - wait 1t
            - define radius:-:<[radius].div[0.8]>
            - define points:-:<[points].div[0.8]>
        - foreach <[target].points_between[<[target].above[200]>].distance[0.2]> as:beam:
            - playeffect at:<[beam]> effect:<[functiondata].get[target_particle]> quantity:5 offset:30.0

scorched_earth_outwards:
    type: task
    definitions: caster
    script:
        - define functiondata <[caster].item_in_hand.flag[functiondata].get[params]>
        - define target <[caster].eye_location.ray_trace[entities:*;nonsolids=false;raysize=2;range=<[functiondata].get[vecor_range]>]||null>
        - define effect_type <[functiondata].get[effect_type]>
        - define radius <[functiondata].get[area_radius]>
        - define points 16
        - define particle <[functiondata].get[caster_particle]>
        - repeat 10:
            - define ring <[target].points_around_y[points=<[points]>;radius=<[radius]>]>
            - foreach <[ring]> as:point:
                # - announce to_flagged:Baivo <[point]>
                - playeffect at:<[point]> effect:<[particle]> quantity:1 offset:0.0
                - run <[effect_type]> def.functiondata:<[functiondata]> def.caster:<[caster]> def.target:<[point]>
                - playeffect at:<[point].points_between[<[point].above[50]>].distance[1]> effect:<[functiondata].get[target_particle]> quantity:1 offset:0.0
                - wait 2t
            - define radius:-:<[radius].div[1.9]>
            - define points:-:<[points].div[1.9]>



#$#$#$#
simpleray:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - foreach <[caster].eye_location.points_between[<[target]>].distance[1]> as:ray:
#             - playeffect at:<[ray]> effect:wax_off quantity:1 offset:0.1
#         - playsound <[caster].location> sound:entity_evoker_cast_spell volume:0.5
#         - playeffect at:<[target].above[0.6]> effect:dragon_breath quantity:15 offset:1
#         - if <[targetentity]> != null:
#             - hurt 20 <[targetentity]> source:<[caster]>

# simpleray_item:
#     type: item
#     debug: false
#     material: amethyst_shard
#     display name: <&[item]><&b><bold>Ray Gun
#     lore:
#     - <gray>Shoots Ray
#     - <white>
#     - <gray>(R.I.P Ray 2022-2022)
#     mechanisms:
#         unbreakable: true
#         hides: all

# shrink:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - foreach <[caster].eye_location.points_between[<[target]>].distance[1]> as:ray:
#             - playeffect at:<[ray]> effect:wax_off quantity:1 offset:0.1
#         - playsound <[caster].location> sound:entity_evoker_cast_spell volume:0.5
#         - playeffect at:<[target].above[0.6]> effect:villager_happy quantity:15 offset:1
#         - if <[targetentity]> != null:
#             - age <[targetentity]> baby

# shrink_item:
#     type: item
#     debug: false
#     material: clock
#     display name: <&[item]><&b><bold>Entity Shrink
#     lore:
#     - <gold>♫ Y'all just halfway thoughts ♫
#     - <gray>♫ Not worth the back of my mind ♫
#     - <gold>♫ But to understand the future ♫
#     - <gray>♫ We have to go back in time ♫
#     - <light_purple>✦ Baby, ✦ oh, ✦ baby✦
#     mechanisms:
#         unbreakable: true
#         hides: all

# frenzy:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - foreach <[caster].eye_location.points_between[<[target]>].distance[1]> as:ray:
#             - playeffect at:<[ray]> effect:wax_off quantity:1 offset:0.1
#         - playsound <[caster].location> sound:entity_evoker_cast_spell volume:0.5
#         - playeffect at:<[target].above[0.6]> effect:villager_angry quantity:15 offset:1
#         - if <[targetentity]> != null:
#             - define frenzylist <[targetentity].location.find.living_entities.within[6]||null>
#             - foreach <[frenzylist]> as:frenzy:
#                 - attack <[frenzy]> target:<[frenzy].location.find.living_entities.within[8].random>
#                 - playeffect at:<[frenzy].location.above[1.5]> effect:villager_angry quantity:3 offset:0.2
# frenzy_item:
#     type: item
#     debug: false
#     material: observer
#     display name: <&[item]><&b><bold>Frenzy
#     lore:
#     - <gray><element[☹☹☹☹☹☹☹☹☹☹☹].color_gradient[from=#e06a02;to=#c99804]>
#     - <white>
#     - <gray><element[☹☹☹☹☹☹☹☹☹☹☹].color_gradient[from=#e06a02;to=#c99804]>
#     mechanisms:
#         unbreakable: true
#         hides: all

# ignite:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - foreach <[caster].eye_location.points_between[<[target]>].distance[1]> as:ray:
#             - playeffect at:<[ray]> effect:flame quantity:1 offset:0.1
#         - playsound <[caster].location> sound:entity_ghast_shoot volume:1
#         - if <[targetentity]> != null:
#             - define targetlist <[targetentity].location.find.living_entities.within[3]||null>
#             - foreach <[targetlist]> as:ignite:
#                 - burn <[ignite]> duration:6
#                 - playeffect at:<[ignite].location.above[1.5]> effect:flame quantity:5 offset:0.2

# ignite_item:
#     type: item
#     debug: false
#     material: blaze_powder
#     display name: <&[item]><red><bold>Ignite
#     lore:
#     - <gray>Ignites entities in a radius at the target
#     - <white>
#     - <gray>Range 200|Radius 3
#     mechanisms:
#         unbreakable: true
#         hides: all

# targetleash:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - playsound <[caster].location> sound:entity_leash_knot_place volume:1
#         - define targetlist <[caster].location.find.living_entities.within[5]||null>
#         - foreach <[targetlist]> as:targetleash:
#             - leash <[targetleash]> holder:<[caster]>

# targetleash_item:
#     type: item
#     debug: false
#     material: lead
#     display name: <&[item]><&b><bold>Mass Leash
#     lore:
#     - <gray>Leashes entities in a radius
#     - <white>
#     - <gray>Radius: 5
#     mechanisms:
#         unbreakable: true
#         hides: all

# fishgun:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - repeat 20:
#             - define fish <list[frog]>
#             - shoot <[fish].random> origin:<[caster]> destination:<[target]> speed:6 spread:4.0

# fishgun_item:
#     type: item
#     debug: false
#     material: pufferfish
#     display name: <&[item]><&a><bold>Fish Gun
#     lore:
#     - <gray>Shoots fish
#     - <white>
#     - <gray>fish
#     mechanisms:
#         unbreakable: true
#         hides: all

# pushaway:
#     type: task
#     debug: true
#     definitions: caster|target|targetentity
#     script:
#         - define targetlist <empty>
#         - foreach <[caster].eye_location.points_between[<[target]>].distance[2]> as:ray:
#             - playeffect at:<[ray]> effect:cloud quantity:1 offset:1
#             - define found <[ray].find.living_entities.within[3]>
#             - define targetlist <list[<[targetlist]>|<[found]>].combine>
#             - define targetlist <[targetlist].exclude[<player>]>
#             - define targetlist <[targetlist].deduplicate>
#             # - define targetlist <[targetlist].deduplicate>
#         - playsound <[caster].location> sound:entity_blaze_shoot volume:1
#         - foreach <[targetlist]> as:targetleash:
#             - if <[targetleash].entity_type> != ARMOR_STAND:
#                 - shoot <[targetleash]> origin:<[targetleash].location> destination:<[targetleash].location.face[<[caster].location>].backward[20]>
#                 - playeffect at:<[targetleash].location.above[1.5]> effect:cloud quantity:3 offset:0.2

# pushaway_item:
#     type: item
#     debug: false
#     material: phantom_membrane
#     display name: <&[item]><gray><bold>Push
#     lore:
#     - <gray>Push things away
#     - <white>
#     - <gray>Push Real Far!
#     mechanisms:
#         unbreakable: true
#         hides: all

# animatedev:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - define radius 1
#         - define points 12
#         - repeat 20:
#             - define ring <[caster].location.points_around_y[points=<[points]>;radius=<[radius]>]>
#             - playeffect at:<[ring]> effect:dripping_obsidian_tear quantity:4 offset:10
#             - define radius:+:<[radius].mul[0.3]>
#             - define points:+:<[points].mul[0.4]>
#             - wait 2t

# animatedev_item:
#     type: item
#     debug: false
#     material: stone
#     display name: <&[item]><&b><bold>dev-animate
#     lore:
#     - <gray>Ldev
#     - <white>
#     - <gray>Radius: 5
#     mechanisms:
#         unbreakable: true
#         hides: all

# personeldev:
#     type: task
#     definitions: caster|target|targetentity
#     script:
#         - define blocks <player[ShiftyThrifty12].location.find_blocks[air].within[3]>
#         - teleport <player[Baivo]> <[blocks].random.face[<player[TinkTheTank].location>]>

# personeldev_item:
#     type: item
#     debug: false
#     material: stone
#     display name: <&[item]><&b><bold>dev-personel
#     lore:
#     - <gray>Ldev
#     - <white>
#     - <gray>Radius: 5
#     mechanisms:
#         unbreakable: true
#         hides: all

# tntcannon:
#     type: task
#     debug: true
#     definitions: caster|target|targetentity
#     script:
#         - shoot PRIMED_TNT|PRIMED_TNT|PRIMED_TNT|PRIMED_TNT|PRIMED_TNT origin:<[caster].location> destination:<[caster].cursor_on_solid>

# tntcannon_item:
#     type: item
#     debug: false
#     material: tnt
#     display name: <&[item]><red><bold>TNT Cannon
#     lore:
#     - <red>Spy, why did you draw yourself
#     - <red>as a buff two-legged wolf person?
#     - <gray><italic>Thats... my fursona...
#     - <red>Your fucking what?
#     - <gray><italic>HIS NAME IS DUTCH. HE'S MY FURSONA
#     - <gray><italic>I roleplay as a soft shy-wolf on twitter...
#     mechanisms:
#         unbreakable: true
#         hides: all


# ####wand

# wand_item:
#     type: item
#     debug: false
#     material: nether_star
#     display name: <&[item]><dark_gray><bold>BIVCO<&sp><dark_purple><bold>EM-1
#     lore:
#     - <dark_gray><bold>BIVCO <dark_purple><bold>Executive Nano Division
#     - <white>
#     - <red>Left click <gray>to adjust function
#     - <white>
#     - <green>Right click <gray>to activate function
#     mechanisms:
#         unbreakable: true
#         hides: all
#         custom_model_data: 18001
#     flags:
#         wand: true
#         spell: none

# wand_item_handler:
#   type: world
#   debug: false
#   events:
#     after player left clicks block with:item_flagged:wand:
#     - run wand_GUI_script
#     - determine cancelled passively

# wand_GUI_script:
#     type: task
#     script:
#     - ratelimit <player> 10t
#     - define wandlist <map[1=fishgun_item;2=simpleray_item;3=shrink_item;4=frenzy_item;5=ignite_item;6=targetleash_item;7=pushaway_item;8=animatedev_item;9=tntcannon_item]>
#     - define inv <inventory[wand_gui]>
#     - foreach <[wandlist]>:
#         - inventory set d:<[inv]> slot:<[key]> o:<[value]>
#         - inventory adjust d:<[inv]> slot:<[key]> flag:spellguiitem
#     - inventory open d:<[inv]>

# wand_gui:
#   type: inventory
#   inventory: chest
#   title: <dark_green>AHHHHH
#   size: 9
#   gui: true

# wand_GUI_handler:
#     type: world
#     events:
#         after player left clicks !air in wand_gui:
#         - if <context.item.has_flag[spellguiitem]>:
#             - define spell <item[<context.item>].script.name.replace[_item]>
#             - inventory adjust slot:hand flag:spell:<[spell]>
#             - narrate "<&7>You have chosen: <item[<context.item>].display>"

# wand:
#     type: world
#     debug: false
#     events:
#         on player right clicks block type:* with:wand_item:
#             - determine cancelled passively
#             - ratelimit <player> 1t
#             - define caster <player>
#             - define target <player.eye_location.ray_trace[entities:*;raysize=2;range=50]||null>
#             - define entityfind <[target].find.living_entities.within[1.5]||null>
#             - define targetentity <[entityfind].get[1]||null>
#             - define spell <player.item_in_hand.flag[spell]>
#             - run <player.item_in_hand.flag[spell]> def.caster:<[caster]> def.target:<[target]> def.targetentity:<[targetentity]>
