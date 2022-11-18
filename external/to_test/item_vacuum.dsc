# Author: Unknown
# Some interesting entity and item interactions

vacuum_item:
    type: item
    debug: false
    material: hopper
    display name: <&[item]>Vacuum
    enchantments:
    - vanishing_curse:1
    mechanisms:
        hides: all

vacuum_entity:
    type: entity
    entity_type: armor_stand
    mechanisms:
        visible: false
        gravity: false
        marker: true
        is_small: true
        equipment:
            helmet: vacuum_item

vacuum_world:
    type: world
    debug: false
    events:
        on player right clicks block with:vacuum_item:
        - determine passively cancelled
        - wait 1t
        - if <player.flag[vacuum_queue].as_queue.exists>:
            - stop
        - flag <player> vacuum_queue:<queue>
        - spawn vacuum_entity <player.location.forward[5]> save:spawned
        - define spawned <entry[spawned].spawned_entity>
        - if !<[spawned].is_spawned||false>:
            - narrate "<&[error]>Vacuum broke"
            - stop
        - while <player.is_online> && <player.is_spawned> && <player.item_in_hand.advanced_matches[vacuum_item]>:
            - wait 1t
            - adjust <[spawned]> move:<player.location.forward[5].above[0.3].sub[<[spawned].location>]>
            - foreach <[spawned].location.find_entities[dropped_item|experience_orb|mob].within[7]> as:victim:
                - define rel <[spawned].location.sub[<[victim].location>]>
                - playeffect effect:town_aura at:<[spawned].location.points_between[<[victim].location>].distance[0.5].random[<element[2].div[<[rel].length>].round_up>].parse[above]> offset:0.1
                - adjust <[victim]> velocity:<[rel].normalize.mul[<element[5].div[<[rel].length.sqrt>]>]>
            - foreach <[spawned].location.find_entities[dropped_item|experience_orb|mob].within[2]> as:victim:
                - adjust <[spawned]> fake_pickup:<[victim]>
        - remove <[spawned]>
