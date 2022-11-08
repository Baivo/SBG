netblock:
    type: world
    debug: false
    events:
        on player places block:
            - if <context.item_in_hand.has_custom_model_data> && ( <context.material.name> = waxed_weathered_copper ):
                - flag <context.location.center> netblock
                - flag <context.location.center> connections
        on player breaks block location_flagged:netblock:
            - define netblock <context.location.center>
            - foreach <[netblock].flag[connections]> as:connection:
              - foreach <[connection].list_flags> as:cflag:
                - flag <[connection]> <[cflag]>:!
            - foreach <[netblock].list_flags> as:flag:
                - flag <context.location.center> <[flag]>:!
            - determine NOTHING passively

netblock_connector_detection:
  type: world
  events:
    on player walks location_flagged:netblockfunction:
    - ratelimit <player> 1t
    - define netblock <context.new_location.center.flag[netblock]>
    - define function <[netblock].flag[function]>
    - run <[function]> def.trigger:<context.new_location.center> def.trigger_netblock:<[netblock]> def.player:<player>

netblock_configurator_events:
  type: world
  debug: true
  events:
    on player left clicks block type:!air location_flagged:netblock with:netblockconfiguratoritem:
    - inventory adjust d:<player.inventory> slot:hand flag:netblock:<context.location.center> expire:1h
    - define netblock <context.location.center>
    - actionbar "<&7>Configuring netblock at: <&color[#bfbfbf]>x <&color[#d65c5c]><[netblock].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[netblock].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[netblock].round_down.z>"
    - determine passively cancelled
# # # # # # # # # # #
    on player right clicks block type:!air location_flagged:netblock with:netblockconfiguratoritem:
    - define netblock <context.location.center>
    - clickable save:connectionclear:
      - foreach <location[<[netblock]>].flag[connections]> as:connection:
        - flag <[connection]> netblock:!
        - flag <[connection]> netblockfunction:!
        - flag <[netblock]> connections:!
      - actionbar "<&c>Cleared all connections from netblock at <[netblock]>""
    - clickable save:functionlist:
      - if <[netblock].has_flag[function]>:
        - narrate "<&a>Netblock function: <&e><[netblock].flag[function]>"
      - else:
          - actionbar "<&c>Netblock has no function"
    - clickable save:functionselect:
      - flag <player> netblock:<[netblock]>
      - narrate "<&7>Enter function name:"
    - define functionselect "<&a>[Set Function By Name]"
    - define functionlist "<&b>[List Functions]"
    - define connectionclear "<&c>[Reset Connections]"
    - actionbar "<&7>Netblock at: <&color[#bfbfbf]>x <&color[#d65c5c]><[netblock].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[netblock].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[netblock].round_down.z>"
    - narrate <element[<[functionselect]>].on_click[<entry[functionselect].command>]><&sp><&sp><element[<[functionlist]>].on_click[<entry[functionlist].command>]><&sp><&sp><element[<[connectionclear]>].on_click[<entry[connectionclear].command>]>
    - flag <player> netblock:<[netblock]>
    - narrate "<&7>Enter function name:"
    - determine passively cancelled
# # # # # # # # # # #
    on player left clicks air with:netblockconfiguratoritem:
    - ratelimit <player> 1s
    - if <location[<player.item_in_hand.flag[netblock]>].has_flag[netblock]>:
      - define netblock <player.item_in_hand.flag[netblock]>
      - actionbar "<&7>Configuring netblock at: <&color[#bfbfbf]>x <&color[#d65c5c]><[netblock].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[netblock].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[netblock].round_down.z>"
      - debugblock <player.item_in_hand.flag[netblock]> color:0,255,0 players:<player.item_in_hand.flag[netblock].find_players_within[32]> d:25t
    - else:
      - actionbar "<&c>Configurator not set to a netblock"
    - determine passively cancelled
# # # # # # # # # # #
    on player right clicks air with:netblockconfiguratoritem:
    - ratelimit <player> 1s
    - if <location[<player.item_in_hand.flag[netblock]>].has_flag[netblock]>:
      - define netblock <player.item_in_hand.flag[netblock]>
      - if <location[<[netblock]>].flag[connections].any>:
        - actionbar "<&a>Connections: <&e><location[<[netblock]>].flag[connections].size.sub_int[1]>"
        - foreach <location[<player.item_in_hand.flag[netblock]>].flag[connections]> as:functionblock:
          - debugblock <[functionblock]> color:0,128,0 players:<player> d:80t
      - else:
        - actionbar "<&c>No connections for currnet netblock"
    - else:
      - actionbar "<&c>Configurator not set to a netblock"
    - determine passively cancelled
# # # # # # # # # # #
    on player right clicks block type:!air with:netblockconfiguratoritem:
      - define netblock <player.item_in_hand.flag[netblock]>
      - if <[netblock].has_flag[netblock]>:
        - define block <context.relative>
        - debugblock <[block]> players:<[block].find_players_within[32]> d:3s
        - actionbar "<&a>Connected: <&color[#bfbfbf]>x <&color[#d65c5c]><[block].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[block].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[block].round_down.z>"
        - flag <[block]> netblockfunction
        - flag <[block]> netblock:<[netblock]>
        - flag <[netblock]> connections:->:<[block]>
        - determine passively cancelled
      - else:
        - actionbar "<&a>No netblock connected. Left click a netblock with the configurator to connect it."
# # # # # # # # # # #
netblock_chat_handler:
    type: world
    debug: false
    events:
        on player chats flagged:netblock:
            - define netblock <player.flag[netblock]>
            - flag <[netblock]> function:<context.message>
            - narrate "<&a>Netblock function set to: <&e><context.message>"
            - flag <player> netblock:!
            - determine cancelled

### ITEMS BELOW ###
netblockconfiguratoritem:
  type: item
  material: spectral_arrow
  display name: <&color[#5fc2a9]>Netblock Configurator
  lore:
  - <&gradient[from=<&d>;to=<&b>]>ダンスフロア
  - <&[lore]><&color[#357541]>█<&color[#73bd81]><&o> Left click a netblock to begin configuration      <&color[#357541]>█
  - <&[lore]><&color[#357541]>█<&color[#73bd81]><&o> Left click the air to show the current netblock <&color[#357541]>█
  - <&[lore]><&color[#357541]>█<&color[#73bd81]><&o>                                                             <&color[#357541]>█
  - <&[lore]><&color[#357541]>█<&color[#73bd81]><&o> Right click the air to show netblock connections<&color[#357541]>█
  - <&[lore]><&color[#357541]>█<&color[#73bd81]><&o> Right click a block to place a connection         <&color[#357541]>█
  mechanisms:
    custom_model_data: 18
  recipes:
    1:
      type: shapeless
      input: <item[barrier]>|<item[arrow]>

netblockitem:
  type: item
  material: waxed_weathered_copper
  display name: <&gradient[from=<&7>;to=<&color[#357541]>]>Net Block
  lore:
  - <&[lore]><&gradient[from=<&a>;to=<&7>]><&o>Place down to create a netblock.
  - <&[lore]>
  - <&[lore]><&gradient[from=<&a>;to=<&7>]><&o>Use the configurator to set functions.
  - <&[lore]>
  - <&[lore]><&gradient[from=<&a>;to=<&7>]><&o>Break to remove the netblock.
  - <&[lore]>
  - <&[lore]><&gradient[from=<&a>;to=<&7>]><&o>Removing the netblock will remove all connections.
  mechanisms:
    custom_model_data: 17
  recipes:
    1:
      type: shapeless
      input: <item[barrier]>|<item[observer]>
