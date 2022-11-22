# Author: Baivo
# Created to try and solve a problem that I totally misunderstood, plus I think this performs like a thin and raspy opera singer in a muddy paddock (not great)
blizzardblock:
    type: world
    debug: true
    events:
        on player places block:
            - if <context.item_in_hand.has_custom_model_data> && ( <context.material.name> = blue_ice ):
                - flag <context.location.center> blizzardblock
        on player breaks block location_flagged:blizzardblock:
            - foreach <context.location.center.list_flags> as:flag:
                - flag <context.location.center> <[flag]>:!
            - determine NOTHING passively

blizzardblockitem:
  type: item
  material: blue_ice
  display name: <&b><&l>Blizzard Block
  lore:
  - <&[lore]><&f><&o>Makes it snow!
  - <&[lore]>
  - <&[lore]><&f><&o>Affects the block above itself.
  mechanisms:
    custom_model_data: 17
  recipes:
    1:
      type: shapeless
      input: <item[barrier]>|<item[powder_snow_bucket]>

bbtimer:
    type: world
    events:
        on delta time secondly:
        - foreach <world[world].loaded_chunks> as:chunk:
            - foreach <[chunk].blocks_flagged[blizzardblock]> as:bb:
                - run bbproc def.bb:<[bb]>

bbproc:
    type: task
    debug: true
    definitions: bb
    script:
    - define pb <[bb].above[5]>
    - playeffect effect:snowflake at:<[pb]> quantity:3 offset:1,1,1
    - if <util.random_chance[10]>:
        - modifyblock <[bb].above[2]> snow
