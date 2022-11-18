# Some crackhead on the denizen discord shared this 
SeededPotent:
  type: entity
  debug: false
  entity_type: armor_stand
  flags:
   GrowQuality: 1
   Nutes: 0
   Nutes2: 0
   PotPlant: 1
   Stage: veg
  mechanisms:
    visible: false
    invulnerable: true
    equipment:
    - air
    - air
    - air
    - SeededPot
serverformat:
    type: format
    format: <gray>Server<&co><white> <[text]>
SeedPop:
  type: task
  debug: true
  definitions: Plant
  script:
  - if <[Plant].location.exists> != true:
    - narrate "An Exception has occured with <[Plant]>" format:serverformat
    - stop
  - equip <[Plant]> head:Sprout_item
  - runlater Veg1 delay:3s def:<[Plant]>
Veg1:
  type: task
  debug: true
  definitions: Plant
  script:
  - if <[Plant].location.exists> != true:
    - narrate "An Exception has occured with <[Plant]>" format:serverformat
    - stop
  - if <[Plant].flag[Growquality]> < 1:
    - equip <[Plant]> head:Dead_Plant_item
    - flag <[Plant]> DeadPlant
    - stop
  - if  <[Plant].location.light> < 8 :
      - flag <[Plant]> GrowQuality:-:3
  - else if  <[Plant].location.light> < 10:
      - flag <[Plant]>  GrowQuality:--
  - else if  <[Plant].location.light> > 13:
      - flag <[Plant]>  GrowQuality:++
  - if <[Plant].flag[Growquality]> < -1:
    - equip <[Plant]> head:Dead_Plant_item
    - flag <[Plant]> DeadPlant
  - if <[Plant].flag[Nutes]> >= 0 and <[Plant].flag[Nutes]> < 4:
    - equip <[Plant]> head:Veg1_item
    - flag <[Plant]> GrowQuality:+:2
    - flag <[Plant]> Stage:Veg
    - runlater Veg2 delay:5m def:<[Plant]>
  - else if <[Plant].flag[Nutes]> >= 4:
    - flag <[Plant]> GrowQuality:--
    - runlater Veg2 delay:5m def:<[Plant]>
  - else if <[Plant].flag[Nutes]> < 1:
    - flag <[Plant]> GrowQuality:-:2
    - runlater Veg1 delay:5m def:<[Plant]>
Veg2:
  type: task
  debug: true
  definitions: Plant
  script:
  - if <[Plant].location.exists> != true:
    - narrate "An Exception has occured with <[Plant]>" format:serverformat
    - stop
  - if <[Plant].flag[Growquality]> < 1:
    - equip <[Plant]> head:Dead_Plant_item2
    - flag <[Plant]> DeadPlant
    - stop
  - if  <[Plant].location.light> < 8:
      - flag <[Plant]> GrowQuality:-:2
  - else if  <[Plant].location.light> < 10:
      - flag <[Plant]> GrowQuality:--
  - else if  <[Plant].location.light> > 13:
      - flag <[Plant]>  GrowQuality:++
  - if <[Plant].flag[Nutes]> >= 2 and <[Plant].flag[Nutes]> < 8:
    - equip <[Plant]> head:Veg3_item
    - flag <[Plant]> GrowQuality:+:3
    - runlater Veg3 delay:5m def:<[Plant]>
  - else if <[Plant].flag[Nutes]> < 4:
    - flag <[Plant]> GrowQuality:--
    - runlater Veg2 delay:5m def:<[Plant]>
  - else if <[Plant].flag[Nutes]> >= 8:
    - flag <[Plant]> GrowQuality:-:2
    - runlater Veg3 delay:5m def:<[Plant]>
  - if <[Plant].flag[Growquality]> < 1:
    - equip <[Plant]> head:Dead_Plant_item2
    - flag <[Plant]> DeadPlant
Veg3:
  type: task
  debug: true
  definitions: Plant
  script:
  - if <[Plant].location.exists> != true:
    - narrate "An Exception has occured with <[Plant]>" format:serverformat
    - stop
  - if <[Plant].flag[Growquality]> < 1:
    - equip <[Plant]> head:Dead_Plant_item3
    - flag <[Plant]> DeadPlant
    - stop
  - if  <[Plant].location.light> < 8:
      - flag <[Plant]> GrowQuality:-:2
  - else if  <[Plant].location.light> < 10:
      - flag <[Plant]> GrowQuality:--
  - else if  <[Plant].location.light> > 13:
      - flag <[Plant]>  GrowQuality:++
  - if <[Plant].flag[Nutes]> >= 6 and <[Plant].flag[Nutes]> < 10:
    - equip <[Plant]> head:Veg4_item
    - flag <[Plant]> GrowQuality:+:3
    - runlater Veg4 delay:5m def:<[Plant]>
  - else if <[Plant].flag[Nutes]> < 6:
    - flag <[Plant]> GrowQuality:--
    - runlater Veg3 delay:5m def:<[Plant]>
  - else if <[Plant].flag[Nutes]> >= 10:
    - flag <[Plant]> GrowQuality:-:3
    - runlater Veg4 delay:5m def:<[Plant]>
Veg4:
  type: task
  debug: false
  definitions: Plant
  script:
  - if <[Plant].location.exists> != true:
    - narrate "An Exception has occured with <[Plant]>" format:serverformat
    - stop
  - if <[Plant].flag[Growquality]> < 1:
    - equip <[Plant]> head:Dead_Plant_item4
    - flag <[Plant]> DeadPlant
    - stop
  - if  <[Plant].location.light> < 8:
      - flag <[Plant]> GrowQuality:-:2
  - else if  <[Plant].location.light> < 10:
      - flag <[Plant]> GrowQuality:--
  - else if  <[Plant].location.light> > 13:
      - flag <[Plant]>  GrowQuality:++
  - if <[Plant].flag[Nutes]> >= 8 and <[Plant].flag[Nutes]> <= 14:
    - equip <[Plant]> head:Bloom1_item
    - flag <[Plant]> GrowQuality:+:3
    - flag <[Plant]> stage:Bloom1
    - runlater Bloom1 delay:5m def:<[Plant]>
  - else if <[Plant].flag[Nutes]> < 8:
    - flag <[Plant]> GrowQuality:--
    - runlater Veg4 delay:5m def:<[Plant]>
  - else if <[Plant].flag[Nutes]> > 14:
    - flag <[Plant]> GrowQuality:-:3
    - runlater Bloom1 delay:5m def:<[Plant]>
Bloom1:
  type: task
  debug: false
  definitions: Plant
  script:
  - if <[Plant].location.exists> != true:
    - narrate "An Exception has occured with <[Plant]>" format:serverformat
    - stop
  - if <[Plant].flag[Growquality]> < 8:
    - equip <[Plant]> head:Dead_Plant_item5
    - flag <[Plant]> DeadPlant
    - stop
  - if  <[Plant].location.light> < 8:
      - flag <[Plant]> GrowQuality:-:2
  - else if  <[Plant].location.light> < 10:
      - flag <[Plant]> GrowQuality:--
      - flag <[Plant]> Hermie:+:1
  - else if  <[Plant].location.light> > 13:
      - flag <[Plant]> GrowQuality:++
  - if <[Plant].flag[Nutes2]> >= 1 and <[Plant].flag[Nutes2]> < 4 :
    - equip <[Plant]> head:Bloom2_item
    - flag <[Plant]> Stage:Bloom2
    - flag <[Plant]> GrowQuality:+:2
    - runlater Bloom2 delay:5m def:<[Plant]>
  - if <[Plant].flag[Nutes2]> < 1:
    - flag <[Plant]> GrowQuality:-:3
    - runlater Bloom1 delay:5m def:<[Plant]>
  - if <[Plant].flag[Nutes2]> > 4:
    - flag <[Plant]> GrowQuality:-:1
    - runlater Bloom2 delay:5m def:<[Plant]>
Bloom2:
  type: task
  debug: false
  definitions: Plant
  script:
  - if <[Plant].location.exists> != true:
    - narrate "An Exception has occured with <[Plant]>" format:serverformat
    - stop
  - if <[Plant].flag[Growquality]> < 8:
    - equip <[Plant]> head:Dead_Plant_item6
    - flag <[Plant]> DeadPlant
    - stop
  - if  <[Plant].location.light> < 8:
      - flag <[Plant]> GrowQuality:-:2
  - else if  <[Plant].location.light> < 10:
      - flag <[Plant]> GrowQuality:--
      - flag <[Plant]> Hermie:+:2
  - else if  <[Plant].location.light> > 13:
      - flag <[Plant]> GrowQuality:++
  - if <[Plant].flag[Nutes2]> >= 4 and <[Plant].flag[Nutes2]> < 8 :
    - equip <[Plant]> head:Bloom3_item
    - flag <[Plant]> Stage:Bloom3
    - flag <[Plant]> GrowQuality:+:2
    - runlater Bloom3 delay:5m def:<[Plant]>
  - if <[Plant].flag[Nutes2]> > 4:
    - flag <[Plant]> GrowQuality:-:2
    - runlater Bloom3 delay:5m def:<[Plant]>
  - if <[Plant].flag[Nutes2]> < 4:
    - flag <[Plant]> GrowQuality:-:2
    - runlater Bloom2 delay:5m def:<[Plant]>
Bloom3:
  type: task
  debug: false
  definitions: Plant
  script:
  - if <[Plant].location.exists> != true:
    - narrate "An Exception has occured with <[Plant]>" format:serverformat
    - stop
  - if <[Plant].flag[Growquality]> < 8:
    - equip <[Plant]> head:Dead_Plant_item7
    - flag <[Plant]> DeadPlant
    - stop
  - if  <[Plant].location.light> < 8:
      - flag <[Plant]> GrowQuality:-:2
  - else if  <[Plant].location.light> < 10:
      - flag <[Plant]> GrowQuality:--
      - flag <[Plant]> Hermie:2
  - else if  <[Plant].location.light> > 13:
      - flag <[Plant]> GrowQuality:++
  - if <[Plant].flag[Nutes2]> >= 6 and <[Plant].flag[Nutes2]> < 10 :
    - equip <[Plant]> head:Bloom4_item
    - flag <[Plant]> Stage:Bloom4
    - flag <[Plant]> GrowQuality:+:2
    - runlater Bloom4 delay:5m def:<[Plant]>
  - if <[Plant].flag[Nutes2]> >= 10:
    - flag <[Plant]> GrowQuality:-:1
    - runlater Bloom4 delay:5m def:<[Plant]>
  - if <[Plant].flag[Nutes2]> < 6:
    - flag <[Plant]> GrowQuality:-:2
    - runlater Bloom3 delay:5m def:<[Plant]>
Bloom4:
  type: task
  debug: false
  definitions: Plant
  script:
  - if <[Plant].location.exists> != true:
    - narrate "An Exception has occured with <[Plant]>" format:serverformat
    - stop
  - if <[Plant].flag[Growquality]> < 8:
    - equip <[Plant]> head:Dead_Plant_item8
    - flag <[Plant]> DeadPlant
    - stop
      - if <[Plant].location.exists> != true
    - stop
  - if  <[Plant].location.light> < 8:
      - flag <[Plant]> GrowQuality:-:2
  - else if  <[Plant].location.light> < 10:
      - flag <[Plant]> GrowQuality:--
      - flag <[Plant]> Hermie:2
  - else if  <[Plant].location.light> > 13:
      - flag <[Plant]> GrowQuality:++
  - if <[Plant].flag[Nutes2]> >= 6 and <[Plant].flag[Nutes2]> <= 8 :
    - equip <[Plant]> head:Bloom4_item
    - flag <[Plant]> GrowQuality:+:2
    - flag <[Plant]> Stage:Bloom4
  - if <[Plant].flag[Nutes2]> < 6:
    - flag <[Plant]> GrowQuality:-:2
    - runlater Bloom4 delay:5m def:<[Plant]>
  - if <[Plant].flag[Nutes2]> > 8:
    - flag <[Plant]> GrowQuality:-:2
SeededpotEvent:
    type: world
    debug: false
    events:
        after player right clicks block with:SeededPot:
        - Spawn SeededPotent save:Plant persistent
        - flag <entry[plant].spawned_entity> potplant
        - take scriptname:SeededPot
        - runlater SeedPop delay:2s def.Plant:<entry[plant].spawned_entity>
        on player right clicks block with:CannibusSeeds:
        - determine cancelled
RightClickPlantEvent:
    type: world
    debug: false
    events:
        on player right clicks armor_stand with:NuteJug:
        - if <context.entity.has_flag[deadplant]>:
          - narrate "Your Plant is Dead" format:serverformat
          - remove <context.entity>
          - stop
        - if <context.entity.flag[Stage]> != veg:
          - determine passively cancelled
          - narrate "You need to feed bloom" format:serverformat
          - stop
        - else if <context.entity.has_flag[Nutes]>:
          - take scriptname:nutejug
          - determine passively cancelled
          - flag <context.entity> nutes:++
          - narrate "Watering your plant!" format:serverformat
        on player right clicks armor_stand with:BloomJug:
        - if <context.entity.has_flag[deadplant]>:
          - narrate "Your Plant is Dead" format:serverformat
          - remove <context.entity>
          - stop
        - if <context.entity.flag[Stage]> = bloom4:
          - determine passively cancelled
          - narrate "Its time to harvest your plant"
          - stop
        - else if <context.entity.has_flag[Nutes2]>:
          - take scriptname:bloomjug
          - determine passively cancelled
          - flag <context.entity> nutes2:++
          - narrate "Watering your plant!" format:serverformat
        on player right clicks armor_stand with:Shears:
        - if <context.entity.has_flag[deadplant]>:
          - narrate "Your Plant is Dead" format:serverformat
          - remove <context.entity>
          - stop
        - if <context.entity.flag[Stage]> = veg:
          - remove <context.entity>
          - stop
        - if <context.entity.flag[Stage]> = bloom1:
          - remove <context.entity>
          - stop
        - if <context.entity.flag[Stage]> = Bloom2:
          - define Yield <context.entity.flag[nutes].add[<context.entity.flag[nutes2]>].mul[<context.entity.flag[growquality]>].div[4]>
          - give uncuredquarter quantity:<[Yield].div[28]>
          - if <context.entity.has_flag[hermie]>:
            - define seedyield <context.entity.flag[hermie]>
            - give CannibusSeeds quantity:<[seedyield]>
          - remove <context.entity>
          - stop
        - if <context.entity.flag[Stage]> = Bloom3:
          - define Yield <context.entity.flag[nutes].add[<context.entity.flag[nutes2]>].mul[<context.entity.flag[growquality]>].div[3]>
          - give uncuredquarter quantity:<[Yield].div[28]>
          - if <context.entity.has_flag[hermie]>:
            - define seedyield <context.entity.flag[hermie]>
            - give CannibusSeeds quantity:<[seedyield]>
          - remove <context.entity>
          - stop
        - if <context.entity.flag[Stage]> = Bloom4:
          - define Yield <context.entity.flag[nutes].add[<context.entity.flag[nutes2]>].mul[<context.entity.flag[growquality]>].div[2]>
          - give uncuredquarter quantity:<[Yield].div[28]>
          - if <context.entity.has_flag[hermie]>:
            - define seedyield <context.entity.flag[hermie]>
            - give CannibusSeeds quantity:<[seedyield]>
          - remove <context.entity>
          - stop
        on player right clicks armor_stand:
        - if <context.entity.has_flag[deadplant]>:
          - narrate "Your Plant is Dead" format:serverformat
          - remove <context.entity>
          - stop
        - else if <context.entity.has_flag[potplant]>:
          - determine passively cancelled
NuteJugevent:
    type: world
    debug: false
    events:
        after player right clicks block with:NuteJug:
        - if <player.cursor_on.material.supports[age]>:
            - adjustblock <player.cursor_on> age:<player.cursor_on.material.maximum_age>
            - take scriptname:NuteJug
PipeEvents:
    type: world
    debug: false
    events:
        after player right clicks air with:Bong:
        - if <player.inventory.contains_item[uncured1gram]>:
           - animate <player> animation:arm_swing
           - take scriptname:Uncured1gram
           - playeffect effect:campfire_cosy_smoke at:<player.location.forward_flat[2].add[0,1,0]> quantity:25 data:0.02
           - playsound sound:entity_tnt_primed volume:4 location:<player.location>
           - if <player.flag[high]> = 1:
              - stop
           - else:
             - flag <player> high:1 expire:5m
             - runlater hallucination delay:4s def:<player>
             - random:
               - cast slow duration:5m
               - cast Speed duration:5m
               - cast SATURATION duration:5m
               - cast hunger duration:5m
               - cast weakness duration:5m
               - cast night vison duration:5m
        - if <player.inventory.contains_item[cured1gram]>:
           - animate <player> animation:arm_swing
           - take scriptname:cured1gram
           - playeffect effect:campfire_cosy_smoke at:<player.location.forward_flat[2].add[0,1,0]> quantity:25 data:0.02
           - playsound sound:entity_tnt_primed volume:4 location:<player.location>
           - if <player.flag[high]> = 1:
              - stop
           - else:
             - flag <player> high:1 expire:5m
             - runlater hallucinationgood delay:4s def:<player>
             - random:
               - cast health_boost duration:5m
               - cast Speed duration:5m
               - cast LUCK duration:5m
               - cast SPEED duration:5m
               - cast regeneration duration:5m
               - cast DOLPHINS_GRACE duration:5m
               - cast SLOW_FALLING duration:5m
        after player right clicks air with:GandalfPipe:
        - if <player.inventory.contains_item[uncured1gram]>:
           - animate <player> animation:arm_swing
           - take scriptname:Uncured1gram
           - playeffect effect:campfire_cosy_smoke at:<player.location.forward_flat[2].add[0,1,0]> quantity:25 data:0.02
           - playsound sound:entity_tnt_primed volume:4 location:<player.location>
           - if <player.flag[high]> = 1:
              - stop
           - else:
             - flag <player> high:1 expire:5m
             - runlater hallucination delay:4s def:<player>
             - random:
               - cast slow duration:5m
               - cast Speed duration:5m
               - cast SATURATION duration:5m
               - cast hunger duration:5m
               - cast weakness duration:5m
               - cast night vison duration:5m
        - if <player.inventory.contains_item[cured1gram]>:
           - animate <player> animation:arm_swing
           - take scriptname:cured1gram
           - playeffect effect:campfire_cosy_smoke at:<player.location.forward_flat[2].add[0,1,0]> quantity:25 data:0.02
           - playsound sound:entity_tnt_primed volume:4 location:<player.location>
           - if <player.flag[high]> = 1:
              - stop
           - else:
             - flag <player> high:1 expire:5m
             - runlater hallucinationgood delay:4s def:<player>
             - random:
               - cast health_boost duration:5m
               - cast Speed duration:5m
               - cast LUCK duration:5m
               - cast SPEED duration:5m
               - cast regeneration duration:5m
               - cast DOLPHINS_GRACE duration:5m
               - cast SLOW_FALLING duration:5m
CuringEvents:
    type: world
    debug: false
    events:
        on player opens barrel:
        - ratelimit <player> 10m
        - define barrel <context.inventory>
        - runlater Cured delay:10m def:<[barrel]>
Cured:
  type: task
  debug: false
  definitions: barrel
  script:
        - foreach <[barrel].find_all_items[uncured1gram]> as:weed:
           - define quantity <[barrel].slot[<[weed]>].quantity>
           - take slot:<[weed]> from:<[barrel]> quantity:<[barrel].slot[<[weed]>].quantity>
           - wait 10t
           - give scriptname:cured1gram to:<[barrel]> slot:<[weed]> quantity:<[quantity]>
        - foreach <[barrel].find_all_items[UncuredEighth]> as:weed:
           - define quantity <[barrel].slot[<[weed]>].quantity>
           - take slot:<[weed]> from:<[barrel]> quantity:<[barrel].slot[<[weed]>].quantity>
           - wait 10t
           - give scriptname:curedEighth to:<[barrel]> slot:<[weed]> quantity:<[quantity]>
        - foreach <[barrel].find_all_items[uncuredquarter]> as:weed:
           - define quantity <[barrel].slot[<[weed]>].quantity>
           - take slot:<[weed]> from:<[barrel]> quantity:<[barrel].slot[<[weed]>].quantity>
           - wait 10t
           - give scriptname:curedquarter to:<[barrel]> slot:<[weed]> quantity:<[quantity]>
        - foreach <[barrel].find_all_items[uncuredhalfounce]> as:weed:
           - define quantity <[barrel].slot[<[weed]>].quantity>
           - take slot:<[weed]> from:<[barrel]> quantity:<[barrel].slot[<[weed]>].quantity>
           - wait 10t
           - give scriptname:curedhalfounce to:<[barrel]> slot:<[weed]> quantity:<[quantity]>
        - foreach <[barrel].find_all_items[uncuredounce]> as:weed:
           - define quantity <[barrel].slot[<[weed]>].quantity>
           - take slot:<[weed]> from:<[barrel]> quantity:<[barrel].slot[<[weed]>].quantity>
           - wait 10t
           - give scriptname:curedounce to:<[barrel]> slot:<[weed]> quantity:<[quantity]>

ItemEvents:
    type: world
    debug: false
    events:
        after player right clicks air with:Raygunitem:
        - if <player.inventory.contains_item[redstone]>:
          - ratelimit <player> 10t
          - animate <player>  animation:arm_swing
          - take item:redstone
          - shoot snowball origin:<player> speed:3 script:Raygun
          - playsound sound:item_crossbow_shoot location:<player.location> volume:2 pitch:2
Raygun:
  type: task
  debug: false
  definitions: hit_entities location
  script:
  - cast slow amplifier:3 duration:5s <[hit_entities]>
  - hurt 8 <[hit_entities]>
  - playsound <[location]> sound:block_amethyst_cluster_hit volume:4 pitch:3
hallucination:
  type: task
  debug: false
  definitions: Player
  script:
  - random:
    - repeat 1:
      - fakespawn ender_crystal <[player].location.forward[5].up[2]>
      - fakespawn ender_crystal <[player].location.backward[5].up[2]>
      - fakespawn ender_crystal <[player].location.left[5].up[2]>
      - fakespawn ender_crystal <[player].location.right[5].up[2]>
    - fakespawn minecart_chest <[player].location.forward[5]>
    - repeat 1:
      - fakespawn Primed_tnt <[player].location.forward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.backward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.left[2].up[2]>
      - fakespawn Primed_tnt <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Primed_tnt <[player].location.forward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.backward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.left[2].up[2]>
      - fakespawn Primed_tnt <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Primed_tnt <[player].location.forward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.backward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.left[2].up[2]>
      - fakespawn Primed_tnt <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Shulker_bullet <[player].location.forward[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.backward[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.left[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Trident <[player].location.forward[2].up[2]>
      - fakespawn Trident <[player].location.backward[2].up[2]>
      - fakespawn Trident <[player].location.left[2].up[2]>
      - fakespawn Trident <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Trident <[player].location.forward[2].up[2]>
      - fakespawn Trident <[player].location.backward[2].up[2]>
      - fakespawn Trident <[player].location.left[2].up[2]>
      - fakespawn Trident <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Trident <[player].location.forward[2].up[2]>
      - fakespawn Trident <[player].location.backward[2].up[2]>
      - fakespawn Trident <[player].location.left[2].up[2]>
      - fakespawn Trident <[player].location.right[2].up[2]>
    - fakespawn creeper <[player].location.forward[5]>
    - spawn illusioner <[player].location.forward[5].up[2]>
    - narrate "The Void is calling" format:serverformat
    - narrate "You need to come down" Format:serverformat
    - narrate "Lets smoke" format:serverformat
    - fakespawn creeper <[player].location.random_offset[4,0,4]>
    - fakespawn zombie <[player].location.random_offset[4,0,4]>
    - fakespawn skeleton <[player].location.random_offset[4,0,4]>
    - fakespawn wither <[player].location.backward[4].up[4]>
    - fakespawn vindicator <[player].location.random_offset[4,4,4]>
    - teleport <player> <player.location.random_offset[15,0,15]>
    - narrate "Lets smoke" format:serverformat
    - fakespawn creeper <[player].location.random_offset[4,0,4]>
    - fakespawn zombie <[player].location.random_offset[4,0,4]>
    - fakespawn skeleton <[player].location.random_offset[4,0,4]>
    - fakespawn wither <[player].location.backward[4].up[4]>
    - fakespawn vindicator <[player].location.random_offset[4,4,4]>
    - teleport <player> <player.location.random_offset[15,0,15]>
    - repeat 1:
      - showfake nether_block <player.location.random_offset[10,0,10]>
      - showfake nether_block <player.location.random_offset[10,0,10]>
      - showfake nether_block <player.location.random_offset[10,0,10]>
    - toast "Wooooot" icon:iron_spade
    - strike <player.location>
    - time player 500t freeze
    - weather player storm reset:2m
    - time player 500t night
    - adjust <player> body_arrows:30
  - random:
    - wait 1m
    - wait 25s
    - wait 5s
    - wait 30s
    - wait 5s
  - random:
    - repeat 1:
      - fakespawn ender_crystal <[player].location.forward[5].up[2]>
      - fakespawn ender_crystal <[player].location.backward[5].up[2]>
      - fakespawn ender_crystal <[player].location.left[5].up[2]>
      - fakespawn ender_crystal <[player].location.right[5].up[2]>
    - fakespawn minecart_chest <[player].location.forward[5]>
    - repeat 1:
      - fakespawn Primed_tnt <[player].location.forward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.backward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.left[2].up[2]>
      - fakespawn Primed_tnt <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Shulker_bullet <[player].location.forward[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.backward[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.left[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Trident <[player].location.forward[2].up[2]>
      - fakespawn Trident <[player].location.backward[2].up[2]>
      - fakespawn Trident <[player].location.left[2].up[2]>
      - fakespawn Trident <[player].location.right[2].up[2]>
    - spawn illusioner <[player].location.forward[5].up[2]>
    - narrate "The Void is calling" format:serverformat
    - narrate "You need to come down" format:serverformat
    - narrate "Lets smoke" format:serverformat
    - fakespawn creeper <[player].location.random_offset[4,0,4]>
    - fakespawn zombie <[player].location.random_offset[4,0,4]>
    - fakespawn skeleton <[player].location.random_offset[4,0,4]>
    - fakespawn wither <[player].location.backward[4].up[4]>
    - fakespawn vindicator <[player].location.random_offset[4,4,4]>
    - teleport <player> <player.location.random_offset[15,0,15]>
    - toast "Wooooot" icon:iron_spade
    - strike <player.location>
    - time player 500t freeze
    - weather player storm reset:2m
    - time player 500t night
    - adjust <player> body_arrows:30
  - random:
    - wait 1m
    - wait 25s
    - wait 40s
    - wait 30s
    - wait 45s
  - random:
    - repeat 1:
      - fakespawn ender_crystal <[player].location.forward[5].up[2]>
      - fakespawn ender_crystal <[player].location.backward[5].up[2]>
      - fakespawn ender_crystal <[player].location.left[5].up[2]>
      - fakespawn ender_crystal <[player].location.right[5].up[2]>
    - fakespawn minecart_chest <[player].location.forward[5]>
    - repeat 1:
      - fakespawn Primed_tnt <[player].location.forward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.backward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.left[2].up[2]>
      - fakespawn Primed_tnt <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Shulker_bullet <[player].location.forward[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.backward[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.left[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Trident <[player].location.forward[2].up[2]>
      - fakespawn Trident <[player].location.backward[2].up[2]>
      - fakespawn Trident <[player].location.left[2].up[2]>
      - fakespawn Trident <[player].location.right[2].up[2]>
    - spawn illusioner <[player].location.forward[5].up[2]>
    - narrate "The Void is calling" format:serverformat
    - narrate "You need to come down" format:serverformat
    - narrate "Lets smoke" format:serverformat
    - fakespawn creeper <[player].location.random_offset[4,0,4]>
    - fakespawn zombie <[player].location.random_offset[4,0,4]>
    - fakespawn skeleton <[player].location.random_offset[4,0,4]>
    - fakespawn wither <[player].location.backward[4].up[4]>
    - fakespawn vindicator <[player].location.random_offset[4,4,4]>
    - teleport <player> <player.location.random_offset[15,0,15]>
  - wait 2m
  - flag <[player]> high:!
hallucinationgood:
  type: task
  debug: false
  definitions: Player
  script:
  - random:
    - repeat 1:
      - spawn pig <[player].location.forward[5].up[2]>
      - spawn pig <[player].location.backward[5].up[2]>
    - fakespawn minecart_hopper <[player].location.forward[5]>
    - repeat 1:
      - spawn axolotl <[player].location.forward[2].up[2]>
    - repeat 4:
      - fakespawn axolotl <[player].location.forward[2].up[2]>
      - fakespawn axolotl <[player].location.backward[2].up[2]>
      - fakespawn axolotl <[player].location.left[2].up[2]>
      - fakespawn axolotl <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn llama <[player].location.forward[2].up[2]>
      - fakespawn llama <[player].location.backward[2].up[2]>
      - fakespawn llama <[player].location.left[2].up[2]>
      - fakespawn llama <[player].location.right[2].up[2]>
    - repeat 4:
      - fakespawn Trident <[player].location.forward[2].up[2]>
      - fakespawn Trident <[player].location.backward[2].up[2]>
      - fakespawn Trident <[player].location.left[2].up[2]>
      - fakespawn Trident <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Trident <[player].location.forward[2].up[2]>
      - fakespawn Trident <[player].location.backward[2].up[2]>
      - fakespawn Trident <[player].location.left[2].up[2]>
      - fakespawn Trident <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Trident <[player].location.forward[2].up[2]>
      - fakespawn Trident <[player].location.backward[2].up[2]>
      - fakespawn Trident <[player].location.left[2].up[2]>
      - fakespawn Trident <[player].location.right[2].up[2]>
    - fakespawn goat <[player].location.forward[5]>
    - spawn iron_golem <[player].location.forward[5].up[2]>
    - narrate "The Void is calling" format:serverformat
    - narrate "You need to come down" Format:serverformat
    - narrate "Lets smoke" format:serverformat
    - fakespawn mushroom_cow <[player].location.random_offset[4,0,4]>
    - fakespawn cat <[player].location.random_offset[4,0,4]>
    - fakespawn wolf <[player].location.random_offset[4,0,4]>
    - fakespawn axolotl <[player].location.backward[4].up[4]>
    - fakespawn sheep <[player].location.random_offset[4,4,4]>
    - teleport <player> <player.location.random_offset[15,0,15]>
    - narrate "The sky feels bluer somehow" format:serverformat
    - toast "Wooooot" icon:iron_spade
    - strike no_damage <player.location>
    - time player 500t freeze
    - weather player storm reset:2m
    - time player 500t day
    - adjust <player> body_arrows:3
    - give <[player]> Raygunitem
  - random:
    - wait 1m
    - wait 25s
    - wait 40s
    - wait 30s
    - wait 45s
  - random:
    - repeat 1:
      - fakespawn villager <[player].location.forward[5].up[2]>
      - fakespawn villager <[player].location.backward[5].up[2]>
      - fakespawn villager <[player].location.left[5].up[2]>
      - fakespawn villager <[player].location.right[5].up[2]>
    - fakespawn minecart_hopper <[player].location.forward[5]>
    - repeat 1:
      - fakespawn salmon <[player].location.forward[2].up[2]>
      - fakespawn salmon <[player].location.backward[2].up[2]>
      - fakespawn salmon <[player].location.left[2].up[2]>
      - fakespawn salmon <[player].location.right[2].up[2]>
    - repeat 1:
      - spawn fox <[player].location.backward[2].up[2]>
    - repeat 1:
      - spawn parrot <[player].location.backward[2].up[2]>
      - spawn parrot <[player].location.left[2].up[2]>
    - repeat 1:
      - fakespawn Shulker_bullet <[player].location.forward[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.backward[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.left[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Trident <[player].location.forward[2].up[2]>
      - fakespawn Trident <[player].location.backward[2].up[2]>
      - fakespawn Trident <[player].location.left[2].up[2]>
      - fakespawn Trident <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Trident <[player].location.forward[2].up[2]>
      - fakespawn Trident <[player].location.backward[2].up[2]>
      - fakespawn Trident <[player].location.left[2].up[2]>
      - fakespawn Trident <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Trident <[player].location.forward[2].up[2]>
      - fakespawn Trident <[player].location.backward[2].up[2]>
      - fakespawn Trident <[player].location.left[2].up[2]>
      - fakespawn Trident <[player].location.right[2].up[2]>
    - fakespawn goat <[player].location.forward[5]>
    - spawn iron_golem <[player].location.forward[5].up[2]>
    - narrate "Knock Knock" format:serverformat
    - narrate "You need to come down" format:serverformat
    - narrate "Lets smoke" format:serverformat
    - fakespawn mushroom_cow <[player].location.random_offset[4,0,4]>
    - fakespawn cat <[player].location.random_offset[4,0,4]>
    - fakespawn wolf <[player].location.random_offset[4,0,4]>
    - fakespawn axolotl <[player].location.backward[4].up[4]>
    - fakespawn sheep <[player].location.random_offset[4,4,4]>
    - teleport <player> <player.location.random_offset[15,0,15]>
    - narrate "The sky feels bluer somehow" format:serverformat
    - drop nether_block <player.location.random_offset[10,0,10]>
  - random:
    - wait 1m
    - wait 25s
    - wait 40s
    - wait 30s
    - wait 45s
  - random:
    - repeat 1:
      - fakespawn ender_crystal <[player].location.forward[5].up[2]>
      - fakespawn ender_crystal <[player].location.backward[5].up[2]>
      - fakespawn ender_crystal <[player].location.left[5].up[2]>
      - fakespawn ender_crystal <[player].location.right[5].up[2]>
    - fakespawn minecart_hopper <[player].location.forward[5]>
    - repeat 1:
      - fakespawn Primed_tnt <[player].location.forward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.backward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.left[2].up[2]>
      - fakespawn Primed_tnt <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Primed_tnt <[player].location.forward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.backward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.left[2].up[2]>
      - fakespawn Primed_tnt <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Primed_tnt <[player].location.forward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.backward[2].up[2]>
      - fakespawn Primed_tnt <[player].location.left[2].up[2]>
      - fakespawn Primed_tnt <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Shulker_bullet <[player].location.forward[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.backward[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.left[2].up[2]>
      - fakespawn Shulker_bullet <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Trident <[player].location.forward[2].up[2]>
      - fakespawn Trident <[player].location.backward[2].up[2]>
      - fakespawn Trident <[player].location.left[2].up[2]>
      - fakespawn Trident <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Trident <[player].location.forward[2].up[2]>
      - fakespawn Trident <[player].location.backward[2].up[2]>
      - fakespawn Trident <[player].location.left[2].up[2]>
      - fakespawn Trident <[player].location.right[2].up[2]>
    - repeat 1:
      - fakespawn Trident <[player].location.forward[2].up[2]>
      - fakespawn Trident <[player].location.backward[2].up[2]>
      - fakespawn Trident <[player].location.left[2].up[2]>
      - fakespawn Trident <[player].location.right[2].up[2]>
    - fakespawn goat <[player].location.forward[5]>
    - spawn iron_golem <[player].location.forward[5].up[2]>
    - narrate "The Void is calling" format:serverformat
    - narrate "You need to come down" Format:serverformat
    - narrate "Lets smoke" format:serverformat
    - fakespawn mushroom_cow <[player].location.random_offset[4,0,4]>
    - fakespawn cat <[player].location.random_offset[4,0,4]>
    - fakespawn wolf <[player].location.random_offset[4,0,4]>
    - fakespawn axolotl <[player].location.backward[4].up[4]>
    - fakespawn sheep <[player].location.random_offset[4,4,4]>
    - teleport <player> <player.location.random_offset[15,0,15]>
    - narrate "The sky feels bluer somehow" format:serverformat
    - drop nether_block <player.location.random_offset[10,0,10]>
  - wait 2m
  - flag <[player]> high:!

Sprout_item:
  type: item
  debug: false
  material: stick
  display name: Sprout
  lore:
  - A Marijuana Sprout.
  mechanisms:
    custom_model_data: 1
Veg1_item:
  type: item
  debug: false
  material: stick
  display name: Veg1Plant
  lore:
  - Veg1 Plant you shouldnt have this!.
  mechanisms:
    custom_model_data: 2
Veg2_item:
  type: item
  debug: false
  material: stick
  display name: Veg2Plant
  lore:
  - Veg2 Plant you shouldnt have this!.
  mechanisms:
    custom_model_data: 7
Veg3_item:
  type: item
  debug: false
  material: stick
  display name: Veg3Plant
  lore:
  - Veg3 Plant you shouldnt have this!.
  mechanisms:
    custom_model_data: 9
Veg4_item:
  type: item
  debug: false
  material: stick
  display name: Veg4Plant
  lore:
  - Veg4 Plant you shouldnt have this!.
  mechanisms:
    custom_model_data: 11
Bloom1_item:
  type: item
  debug: false
  material: stick
  display name: Bloom1
  lore:
  - Bloom1 Plant you shouldnt have this!.
  mechanisms:
    custom_model_data: 13
Bloom2_item:
  type: item
  debug: false
  material: stick
  display name: Bloom2Plant
  lore:
  - Bloom2 Plant you shouldnt have this!.
  mechanisms:
    custom_model_data: 15
Bloom3_item:
  type: item
  debug: false
  material: stick
  display name: Bloom3Plant
  lore:
  - Bloom3 Plant you shouldnt have this!.
  mechanisms:
    custom_model_data: 17
Bloom4_item:
  type: item
  debug: false
  material: stick
  display name: Bloom4Plant
  lore:
  - Bloom4 Plant you shouldnt have this!.
  mechanisms:
    custom_model_data: 19
Dead_Plant_item:
  type: item
  debug: false
  material: stick
  display name: Dead Plant
  lore:
  - Dead Plant try again
  mechanisms:
    custom_model_data: 6
Dead_Plant_item2:
  type: item
  debug: false
  material: stick
  display name: Dead Plant
  lore:
  - Dead Plant try again
  mechanisms:
    custom_model_data: 8
Dead_Plant_item3:
  type: item
  debug: false
  material: stick
  display name: Dead Plant
  lore:
  - Dead Plant try again
  mechanisms:
    custom_model_data: 10
Dead_Plant_item4:
  type: item
  debug: false
  material: stick
  display name: Dead Plant
  lore:
  - Dead Plant try again
  mechanisms:
    custom_model_data: 12
Dead_Plant_item5:
  type: item
  debug: false
  material: stick
  display name: Dead Plant
  lore:
  - Dead Plant try again
  mechanisms:
    custom_model_data: 14
Dead_Plant_item6:
  type: item
  debug: false
  material: stick
  display name: Dead Plant
  lore:
  - Dead Plant try again
  mechanisms:
    custom_model_data: 16
Dead_Plant_item7:
  type: item
  debug: false
  material: stick
  display name: Dead Plant
  lore:
  - Dead Plant try again
  mechanisms:
    custom_model_data: 18

Dead_Plant_item8:
  type: item
  debug: false
  material: stick
  display name: Dead Plant
  lore:
  - Dead Plant try again
  mechanisms:
    custom_model_data: 20
NuteJug:
  type: item
  material: stick
  mechanisms:
    custom_model_data: 4
  display name: NuteJug
  lore:
  - Synthetic Plant Nutrients
  recipes:
      1:
       type: shapeless
       output_quantity: 2
       input: bone|feather|
      2:
             type: shapeless
             output_quantity: 1
             input: brown_mushroom|feather|
BloomJug:
  type: item
  material: stick
  mechanisms:
    custom_model_data: 5
  display name: Bloomjug
  lore:
  - Synthetic Plant Nutrients
  recipes:
      1:
       type: shapeless
       output_quantity: 2
       input: melon|egg|
      2:
             type: shapeless
             output_quantity: 1
             input: beetroot|egg|
CannibusSeeds:
  type: item
  debug: false
  material: Melon_seeds
  display name: Cannibus Seeds
  lore:
  - Seeds to plant Marijuana.
PotPot:
  type: item
  material: Stick
  mechanisms:
    custom_model_data: 3
  display name: PotPot
  lore:
  - A Pot for your pot
  - Combine with Seeds in your inventory
  recipes:
      1:
       type: shapeless
       output_quantity: 1
       input: Flower_Pot|dirt|
SeededPot:
  type: item
  material: Stick
  mechanisms:
    custom_model_data: 3
  display name: Seeded Pot
  lore:
  - Right Click to place
  recipes:
      1:
       type: shapeless
       output_quantity: 1
       input: CannibusSeeds|PotPot|
Cured1gram:
  type: item
  debug: false
  material: stick
  display name: 1 Gram
  lore:
  - Take a trip and never leave the farm...
  - Cured
  mechanisms:
    custom_model_data: 21
  recipes:
      1:
       type: shapeless
       output_quantity: 3
       input: CuredEighth
Uncured1gram:
  type: item
  debug: false
  material: stick
  display name: 1 Gram (Uncured)
  lore:
  - Take a trip and never leave the farm...
  - Uncured
  mechanisms:
    custom_model_data: 21
  recipes:
      1:
       type: shapeless
       output_quantity: 3
       input: UncuredEighth|
CuredEighth:
  type: item
  debug: false
  material: stick
  display name: An Eighth
  lore:
  - Take a trip and never leave the farm...
  - Cured
  mechanisms:
    custom_model_data: 22
  recipes:
      1:
       type: shapeless
       output_quantity: 2
       input: CuredQuarter
      2:
       type: shapeless
       output_quantity: 1
       input: Cured1gram|Cured1gram|Cured1gram

UncuredEighth:
  type: item
  debug: false
  material: stick
  display name: An Eighth (Uncured)
  lore:
  - Take a trip and never leave the farm...
  - Uncured
  mechanisms:
    custom_model_data: 22
  recipes:
      1:
       type: shapeless
       output_quantity: 2
       input: uncuredQuarter
      2:
       type: shapeless
       output_quantity: 1
       input: Uncured1gram|Uncured1gram|Uncured1gram
CuredQuarter:
  type: item
  debug: false
  material: stick
  display name: A Quarter
  lore:
  - Take a trip and never leave the farm...
  - Cured
  mechanisms:
    custom_model_data: 22
  recipes:
      1:
       type: shapeless
       output_quantity: 2
       input: Curedhalfounce
      2:
       type: shapeless
       output_quantity: 1
       input: CuredEighth|CuredEighth
UncuredQuarter:
  type: item
  debug: false
  material: stick
  display name: A Quarter (Uncured)
  lore:
  - Take a trip and never leave the farm...
  - Uncured
  mechanisms:
    custom_model_data: 22
  recipes:
      1:
       type: shapeless
       output_quantity: 2
       input: uncuredhalfounce
      2:
       type: shapeless
       output_quantity: 1
       input: uncuredEighth|uncuredEighth
CuredHalfOunce:
  type: item
  debug: false
  material: stick
  display name: A Half Ounce
  lore:
  - Take a trip and never leave the farm...
  - Cured
  mechanisms:
    custom_model_data: 22
  recipes:
      1:
       type: shapeless
       output_quantity: 2
       input: CuredOunce
      2:
       type: shapeless
       output_quantity: 1
       input: CuredQuarter|CuredQuarter

UncuredHalfOunce:
  type: item
  debug: false
  material: stick
  display name: A Half Ounce (Uncured)
  lore:
  - Take a trip and never leave the farm...
  - Uncured
  mechanisms:
    custom_model_data: 22
  recipes:
      1:
       type: shapeless
       output_quantity: 2
       input: uncuredounce
      2:
       type: shapeless
       output_quantity: 1
       input: uncuredquarter|uncuredquarter
CuredOunce:
  type: item
  debug: false
  material: stick
  display name: A Ounce
  lore:
  - Take a trip and never leave the farm...
  - Cured
  mechanisms:
    custom_model_data: 22
  recipes:
      2:
       type: shapeless
       output_quantity: 1
       input: CuredHalfOunce|CuredHalfOunce
      3:
       type: shaped
       output_quantity: 1
       input:
        - netherite_ingot|netherite_ingot|netherite_ingot
        - black_stained_glass|uncuredounce|black_stained_glass
        - wet_sponge|black_stained_glass|wet_sponge
UncuredOunce:
  type: item
  debug: false
  material: stick
  display name: A Ounce (Uncured)
  lore:
  - Take a trip and never leave the farm...
  - Uncured
  mechanisms:
    custom_model_data: 22
  recipes:
      2:
       type: shapeless
       output_quantity: 1
       input: uncuredhalfounce|uncuredhalfounce
Bong:
  type: item
  debug: false
  material: stick
  display name: Bong
  lore:
  - Like Cheech and Chong
  mechanisms:
    custom_model_data: 23
GandalfPipe:
  type: item
  debug: false
  material: stick
  display name: Gandalf Pipe
  lore:
  - What do you mean?
  - Do you mean to wish me a good morning
  - Or are you saying it is a good morning
  - whether I want it or not?
  - Or perhaps you are saying that you
  - feel good on this particular morning.
  - Or maybe you are suggesting
  - that it is a morning to be good on.
  mechanisms:
    custom_model_data: 24
Raygunitem:
  type: item
  debug: false
  material: stick
  display name: Raygun
  lore:
  - Pew Pew
  - Powered by redstone
  mechanisms:
    custom_model_data: 25
MarijuanaBible:
  type: book
  title: Marijuana Bible
  author: Jorge Blokvantes
  signed: true
  # Each -line in the text section represents an entire page.
  # To create a newline, use the tag <n>. To create a paragraph, use <p>.
  text:
  - Welcome to your Marijuana plant first thing you will need is a PotPot combine a flowerpot and dirt next plant Cannibus seeds in the pot by combining the pot with the seeds.
  - After you have got your seededpot save it untill you have crafted enough nutrients you will need atleast 8 Nutejugs and 6 Bloomjugs Nutejugs can be made with bones and feathers...
  - Or Feathers and Brown Mushrooms. Bloomjugs can be made with Melons and Eggs or Beetroots and Eggs. Now you are ready to place your plant. it will be placed directly on the block you are standing on.
  - You need to water it 2 times everytime you see the plant change stages (every 5 minutes!) once the plant begins to bloom switch to the Bloomjug. When ready to harvest simply right click with shears
  - To cure the plant place Buds in a barrel and check on them every 5 minutes
MarijuanaBiblecommand:
  type: command
  name: MarijuanaBible
  description: Gives you the Marijuana Bible cost 5000
  usage: /Marijuanabible
  script:
  - give MarijuanaBible
  - money take quantity:5000
