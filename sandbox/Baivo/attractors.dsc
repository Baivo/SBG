#| -- Block Attractors --
#|
#| @author acikek
#| @version 1.0.0
#| @date 22/4/22
#|
#| Use the 'attractor' command when holding an item to create a Block Attractor!
#| Example: /attractor vanilla_tagged:stairs 20
#|
#| The system is flag-based, allowing for items like the one below.

leaf_attractor:
  type: item
  material: green_dye
  display name: <green>Leaf Attractor
  lore:
  - <&[lore]>Right-click to strip the leaves off of trees.
  flags:
    attractor:
      match: vanilla_tagged:leaves
      radius: 10

attractor_command:
  type: command
  debug: false
  name: attractor
  description: Generates a block attractor item
  usage: /attractor <&lt>match<&gt> (<&lt>radius<&gt>)
  permission: attractor.command
  tab completions:
    2: 1|5|10|20
  script:
  - if <player.item_in_hand.material.name> == air:
    - narrate "<&[error]>You must be holding an item!"
    - stop
  - if <context.args.is_empty>:
    - narrate "<&[error]>No matcher provided!"
    - stop
  - define radius <context.args.get[2].if_null[10]>
  - if !<[radius].is_decimal>:
    - narrate "<&[error]>Radius must be a number!"
    - stop
  - define match <context.args.first>
  - define matches <server.material_types.filter_tag[<[filter_value].advanced_matches[<[match]>]>]>
  - if <[matches].is_empty>:
    - narrate "<&[error]>No matching materials found! <&[default]>Examples: <&[emphasis]>*_planks<&[default]>, <&[emphasis]>vanilla_tagged:leaves"
    - stop
  - define etc <[matches].size.is_more_than[1].if_true[...].if_false[<empty>]>
  - define name "<&color[<color[random]>]><[matches].random.translated_name><[etc]> Attractor"
  - inventory flag slot:hand attractor:<map[match=<[match]>;radius=<[radius]>]>
  - inventory adjust slot:hand display:<[name]>
  - inventory adjust slot:hand "lore:<&[lore]>Matches <[match]>"
  - inventory adjust slot:hand enchantments:infinity=1
  - inventory adjust slot:hand hides:all
  - narrate "<&[base]>Matched <&[emphasis]><[matches].size> <&[base]>material(s)!"

block_attract:
  type: task
  debug: false
  definitions: match|radius
  script:
  - flag <player> attracting expire:5m
  - foreach <player.location.find_blocks[<[match]>].within[<[radius]>]> as:location:
    - if <[location].material.name> == air:
      - foreach next
    - spawn falling_block[fallingblock_type=<[location].material>] <[location].above[1]> save:block
    - define block <entry[block].spawned_entity>
    - adjust <player> fake_pickup:<[block]>
    - remove <[block]>
    - give <[location].material.item>
    - modifyblock <[location]> air
    - if <[loop_index].mod[5]> == 0:
      - wait 1t
  - flag <player> attracting:!

block_attractor_handler:
  type: world
  debug: false
  events:
    after player right clicks block with:item_flagged:attractor flagged:!attracting:
    - ratelimit <player> 10t
    - define data <context.item.flag[attractor]>
    - define radius <[data].get[radius].if_null[10]>
    - run block_attract def.match:<[data].get[match]> def.radius:<[radius]>
    on player places item_flagged:attractor:
    - determine cancelled