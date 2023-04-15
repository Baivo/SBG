ore_detector_item:
    type: item
    debug: false
    material: spectral_arrow
    display name: <&[item]><gray><bold>Ore <green><bold>Detector
    lore:
    - <red>Left click <gray>to configure targets
    - <white>
    - <green>Right click <gray>to power on/off
    mechanisms:
        unbreakable: true
        hides: all
        custom_model_data: 17
    flags:
        ore_detector: true

ore_detector:
    type: world
    debug: false
    events:
        on delta time secondly:
            - foreach <server.online_players> as:player:
                - if <[player].item_in_hand.has_flag[ore_detectorsearching]> || <[player].item_in_offhand.has_flag[ore_detectorsearching]>:
                    - run ore_detectorlogic def.miner:<[player]>
                - else:
                    - foreach next

ore_detectorlogic:
    type: task
    definitions: miner
    script:
    - foreach <[miner].location.find_blocks[vanilla_tagged:*ores*].within[5]> as:ore:
        - foreach <[ore].center.points_between[<[miner].location.above[1.3]>].distance[0.5]> as:particle:
            - if <[miner].item_in_hand.has_flag[ore_detectorsearching]> || <[miner].item_in_offhand.has_flag[ore_detectorsearching]>:
                - if <util.random_chance[10]>:
                    - playeffect effect:glow at:<[particle]> quantity:3 offset:0.1
                    - playeffect effect:block_dust special_data:<[ore].material.name> at:<[particle]> quantity:1
                    - playsound <[miner].location> sound:block_amethyst_block_chime pitch:2 volume:0.5
            - else:
                - foreach next

##
ore_detector_item_handler:
  type: world
  debug: false
  events:
    after player left clicks block with:item_flagged:ore_detector:
    - run ore_detector_GUI_script
    - determine cancelled passively
    after player right clicks block with:item_flagged:ore_detector:
    - if <player.item_in_hand.has_flag[ore_detectorsearching]>:
        - inventory adjust slot:hand flag:ore_detectorsearching:!
        - inventory adjust slot:hand remove_enchantments
        - inventory adjust slot:hand custom_model_data:17
    - else:
        - inventory adjust slot:hand flag:ore_detectorsearching
        - inventory adjust slot:hand custom_model_data:18

ore_detector_GUI_script:
    type: task
    script:
    - ratelimit <player> 10t
    - define orelist <map[1=coal_ore;2=deepslate_coal_ore;3=iron_ore;4=deepslate_iron_ore;5=copper_ore;6=deepslate_copper_ore;7=gold_ore;8=deepslate_gold_ore;9=nether_gold_ore;10=redstone_ore;11=deepslate_redstone_ore;12=emerald_ore;13=deepslate_emerald_ore;14=lapis_ore;15=deepslate_lapis_ore;16=diamond_ore;17=deepslate_diamond_ore;18=nether_quartz_ore]>
    - define inv <inventory[ore_detector_gui]>
    - foreach <[orelist]>:
        - inventory set d:<[inv]> slot:<[key]> o:<[value]>
        - if <player.item_in_hand.has_flag[<[value]>]>:
            - inventory adjust d:<[inv]> slot:<[key]> enchantments:fortune=10
            - inventory adjust d:<[inv]> slot:<[key]> display:<&a>Searching!
            - inventory adjust d:<[inv]> slot:<[key]> hides:all
            - inventory adjust d:<[inv]> slot:<[key]> flag:ore_detectorguiitem
        - else:
            - inventory adjust d:<[inv]> slot:<[key]> "display:<&c>Not searching!"
            - inventory adjust d:<[inv]> slot:<[key]> hides:all
            - inventory adjust d:<[inv]> slot:<[key]> flag:ore_detectorguiitem
    - inventory open d:<[inv]>

ore_detector_GUI_handler:
    type: world
    events:
        after player left clicks !air in ore_detector_gui:
        - if <context.item.has_flag[ore_detectorguiitem]>:
            - if <player.item_in_hand.has_flag[<context.item.material.name>]>:
                - inventory adjust slot:hand flag:<context.item.material.name>:!
            - else:
                - inventory adjust slot:hand flag:<context.item.material.name>
            - run ore_detector_gui_script
        - else:
            - determine cancelled
ore_detector_gui:
  type: inventory
  inventory: chest
  title: <dark_green>Ore Detector Search Menu
  size: 18
  gui: true