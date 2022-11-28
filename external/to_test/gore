gibbingtask:
  type: task
  definitions: goregiblet
  script:
  - while <[goregiblet].is_spawned||0>:
    - playeffect effect:block_crack quantity:15 special_data:<list[redstone_wire|redstone_block].random> at:<[goregiblet].location> offset:0 velocity:<random_offset[0.2,0.2,0.2]>  visibility:64
    - playeffect effect:redstone quantity:15 special_data:0.9|red at:<[goregiblet].location> offset:0  visibility:64
    - if <list[0|1|2|3|4|5|6].random> == 0:
      - playsound at:<[goregiblet].location> sound:block_honey_block_slide pitch:<list[0.5|0.75|1|1.5|2].random> volume:2
    - if <[goregiblet].is_on_ground>:
      - playeffect effect:block_crack quantity:20 special_data:<list[redstone_wire|redstone_block].random> at:<[goregiblet].location> offset:0 velocity:<random_offset[1,1,1]>
      - playeffect effect:redstone quantity:20 special_data:1.2|red at:<[goregiblet].location> offset:0
      - playsound at:<[goregiblet].location> sound:<list[block_honey_block_break|block_slime_block_break|block_honey_block_slide|block_slime_block_step].random> pitch:<list[0.5|0.6|0.7|0.9|1].random> volume:2
      - playsound at:<[goregiblet].location> sound:<list[entity_salmon_flop|entity_cod_flop].random> pitch:0 volume:2
      - while stop
    - wait 2t
  - remove <[goregiblet]>

goreburstatloc:
  debug: false
  definitions: goreloc
  type: task
  script:
    - repeat 3:
      - playeffect effect:block_crack quantity:120 special_data:<list[redstone_wire|redstone_block].random> at:<[goreloc]> offset:0.5 velocity:<random_offset[4,4,4]>
      - playeffect effect:redstone quantity:10 special_data:1.2|red at:<[goreloc]> offset:1
    - repeat 5:
      - playsound at:<[goreloc]> sound:<list[block_honey_break|block_slime_block_break|block_honey_slide|block_slime_block_step].random> pitch:<list[0.5|0.6|0.7|0.9|1].random> volume:2
    - repeat 8:
      - shoot gore origin:<[goreloc]> spread:90 speed:<list[0.5|0.75|1|1.25].random> destination:<[goreloc].add[0,1,0]> save:goresaving
      - run gibbingtask def:<entry[goresaving].shot_entity>

goreburst:
  debug: false
  definitions: wetentity
  type: task
  script:
    - adjust <[wetentity]> visible:false
    - wait 1t
    - repeat 3:
      - playeffect effect:block_crack quantity:120 special_data:<list[redstone_wire|redstone_block].random> at:<[wetentity].eye_location> offset:0.5 velocity:<random_offset[4,4,4]>  visibility:64
      - playeffect effect:redstone quantity:10 special_data:1.2|red at:<[wetentity].eye_location> offset:1  visibility:64
    - repeat 5:
      - playsound at:<[wetentity].location> sound:<list[block_honey_block_break|block_slime_block_break|block_honey_block_slide|block_slime_block_step].random> pitch:<list[0.5|0.6|0.7|0.9|1].random> volume:2
    - repeat 8:
      - shoot gore origin:<[wetentity].location> spread:90 speed:<list[0.5|0.75|1|1.25].random> destination:<[wetentity].location.add[0,1,0]> save:goresaving
      - run gibbingtask def:<entry[goresaving].shot_entity>
    - playsound at:<[wetentity].location> sound:weather_rain pitch:0 volume:2
    - waituntil rate:10t !<[wetentity].is_spawned> max:3s
    - waituntil rate:10t <[wetentity].is_spawned> max:3s
    - adjust <[wetentity]> visible:true

player_death:
  type: world
  debug: false
  events:
    on entity dies:
      - run goreburstatloc def.goreloc:<context.entity.eye_location>
