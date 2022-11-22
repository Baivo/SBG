# OI mate: :->: and :<-: for connection stacking
### NETBLOCK BLOCK EVENTS ###
netblock_events_netblock:
    type: world
    debug: false
    events:
        # Sets up a netblock at the location
        on player places netblock_item_netblock:
        - define netblock <context.location>
        - flag server netblock.<[netblock]>.connections:<list[]>
        - flag server netblock.<[netblock]>.function:nbf_getstarted
        - flag server netblock.<[netblock]>.owner:<player>
        - flag <[netblock]> netblock:<server.flag[netblock.<[netblock]>]>
        - actionbar "<&7>Created netblock at: <&color[#bfbfbf]>x <&color[#d65c5c]><[netblock].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[netblock].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[netblock].round_down.z>"

        # Clears the netblock at the location and it's connections
        on player breaks block location_flagged:netblock:
        - define netblock <context.location>
        - flag server netblock.<[netblock]>:!
        - flag <[netblock]> netblock:!
        - actionbar "<&7>Removed netblock at: <&color[#bfbfbf]>x <&color[#d65c5c]><[netblock].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[netblock].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[netblock].round_down.z>"
        - determine nothing

### CONNECTION TRIGGER EVENT ###
netblock_events_connection:
    type: world
    debug: false
    events:
        # Runs the function script define by the netblock when a player enters or moves inside a connection
        # I realize this is not the most ideal scenario, as the function will run for every single player walks event fire.
        #
        # Until I put some thought into a better system, the expectation is that the function script will handle the rate-limiting of the event.
        # I've found the use of a "cooldown" flag to be a good way to do this if you want to run the function on a cooldown regardless of the connection
        # Or you can use a second netblock and set of connections to construct a boundary around the original trigger area to clear the flag once the player leaves the area
        on player walks location_flagged:connection:
        - ratelimit <player> 1t
        - define connection <context.new_location>
        - if !<[connection].flag[connection].any>:
          - flag <[connection]> connection:!
          - stop
        - foreach <server.flag[netblock.<[connection]>.netblocks]> as:netblock:
            - define function <server.flag[netblock.<[netblock]>.function]>
            - run <[function]> def.player:<player> def.trigger:<[connection]> def.netblock:<[netblock]> def.function:<[function]>

### CONFIGURATOR EVENTS ###
netblock_events_configurator:
    type: world
    debug: false
    events:
        on player left clicks block location_flagged:netblock with:netblock_item_configurator:
        - define netblock <context.location>
        # Sets the currently active netblock for use with the configurator
        - inventory flag d:<player.inventory> slot:hand currentnetblock:<[netblock]> expire:1h
        - actionbar "<&7>Configurator set to netblock at: <&color[#bfbfbf]>x <&color[#d65c5c]><[netblock].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[netblock].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[netblock].round_down.z>"
        # Clickable to set the netblock's function
        - define functionset "<&a>[Set Function]<&7>"
        - clickable save:functionset:
            - flag <player> netblock:<[netblock]>
            - narrate "<&7>Enter the name of the function to set for this netblock."
            - narrate "<&7>Example: <&color[#bfbfbf]>nbf_getstarted"
            - narrate "<&7>Or enter 'cancel' to keep the current function."
        # Clickable to show the netblock's connections in chat, as well as highlighting each connection with a debugblock
        - define connectionlist "<&e>[Show Connections]<&7>"
        - clickable save:connectionlist:
            - foreach <server.flag[netblock.<[netblock]>.connections]> as:connection:
                - narrate "<&7>- <&color[#bfbfbf]>x <&color[#d65c5c]><[connection].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[connection].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[connection].round_down.z>"
                - debugblock <[connection]> color:0,255,0 players:<player> d:60t
        # Clickable to clear netblock connections
        - define connectionclear "<&c>[Clear Connections]<&7>"
        - clickable save:connectionclear:
            - flag server netblock.<[netblock]>.connections:<list[]>
            - narrate "<&7>Removed all connections for this netblock."
        # Construct the chat menu and send it to the player
        - narrate "<&7>Configuring netblock at: <&color[#bfbfbf]>x <&color[#d65c5c]><[netblock].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[netblock].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[netblock].round_down.z>"
        - narrate "<&7>Current function: <&color[#bfbfbf]><server.flag[netblock.<[netblock]>.function]>"
        - narrate <element[<[functionset]>].on_click[<entry[functionset].command>]><&sp><&sp><element[<[connectionlist]>].on_click[<entry[connectionlist].command>]><&sp><&sp><element[<[connectionclear]>].on_click[<entry[connectionclear].command>]>
        - determine cancelled passively
    # Adds a connection to the currently active netblock if the player is not sneaking
    # Removes a connection from the currently active netblock if the player is sneaking
        on player right clicks !air with:netblock_item_configurator:
        - define netblock <player.item_in_hand.flag[currentnetblock]>
        - define connection <context.relative>
        - if !<player.is_sneaking>:
            - flag server netblock.<[netblock]>.connections:->:<[connection]>
            - flag server netblock.<[connection]>.netblocks:->:<[netblock]>
            - flag <[connection]> connection:->:<[netblock]>
            - actionbar "<&7>Created new connection at: <&color[#bfbfbf]>x <&color[#d65c5c]><[connection].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[connection].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[connection].round_down.z>"
            - debugblock <[connection]> color:0,255,0 players:<player> d:60t
        - else:
            - flag server netblock.<[netblock]>.connections:<server.flag[netblock.<[netblock]>.connections].exclude[<[connection]>]>
            - flag server netblock.<[connection]>.netblocks:<server.flag[netblock.<[connection]>.netblocks].exclude[<[netblock]>]>
            - flag <[connection]> connection:<-:<[netblock]>
            - actionbar "<&7>Removed connection at: <&color[#bfbfbf]>x <&color[#d65c5c]><[connection].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[connection].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[connection].round_down.z>"
        - determine cancelled passively

    # Shows the currently active netblock and it's connections using debug blocks
        on player left clicks air with:netblock_item_configurator:
        - define netblock <player.item_in_hand.flag[currentnetblock]>
        - debugblock <[netblock]> color:0,0,0 players:<player> d:60t
        - foreach <server.flag_map[netblock.<[netblock]>.connections]> as:connection:
            - debugblock <[connection]> color:0,255,0 players:<player> d:60t
        - determine cancelled passively


### CHAT HANDLER ###
netblock_events_chatHandler:
    type: world
    debug: false
    events:
    # Handles chat input for the netblock configurator functionset menu option
        on player chats flagged:netblock:
        - define function <context.message.to_lowercase>
        - if <[function]> == cancel:
            - narrate <&7>Cancelled.
            - flag <player> netblock:!
        - if !<script[<[function]>].exists>:
            - narrate "<&c>Invalid function.<&7><&nl>Try again, or enter 'cancel' to keep the current function."
        - else:
            - define netblock <player.flag[netblock]>
            - flag server netblock.<[netblock]>.function:<[function]>
            - narrate "<&a>netblock function set to: <&e><[function]>"
            - flag <player> netblock:!
        - determine cancelled

### ITEMS ###
netblock_item_configurator:
  type: item
  material: spectral_arrow
  display name: <&color[#5fc2a9]>netblock Configurator
  lore:
  - <&gradient[from=<&d>;to=<&b>]>ダンスフロア
  - <&color[#357541]>█<&color[#c2a8ff]><&o> Configurator controls<&co>
  - <&color[#357541]>█<&color[#73bd81]><&o> Left click a netblock to link the configurator
  - <&color[#357541]>█<&color[#73bd81]><&o> Right click to place a connection
  - <&color[#357541]>█<&color[#73bd81]><&o> Sneak & right click to remove a connection
  - <&color[#357541]>█<&color[#73bd81]><&o> Left click the air to show netblock connections
  mechanisms:
    custom_model_data: 18
  recipes:
    1:
      type: shapeless
      input: <item[barrier]>|<item[arrow]>

netblock_item_netblock:
  type: item
  material: waxed_weathered_copper
  display name: <&gradient[from=<&7>;to=<&color[#357541]>]>netblock
  lore:
  - <&color[#357541]>█<&color[#73bd81]><&o>Use with the netblock configurator!
  - <&color[#357541]>█<&color[#73bd81]><&o>Break by hand to remove the netblock.
  - <&color[#357541]>█<&color[#73bd81]><&o>Removing the netblock will remove all connections.
  - <&color[#357541]>█<&color[#ff4a77]><&o>Removing a netblock by other means will not remove connections.
  - <&color[#357541]>█<&color[#ff4a77]><&o>i.e. worldedit, explosions, etc.
  - <&color[#357541]>█<&color[#bfbfbf]><&o>Fix for this coming Soon™

  mechanisms:
    custom_model_data: 17
  recipes:
    1:
      type: shapeless
      input: <item[barrier]>|<item[observer]>

### SAMPLE SCRIPTS ###
# Placeholder netblock function script to demonstrate use and passing definitions to function scripts
nbf_getstarted:
    type: task
    definitions: trigger|player|netblock
    script:
        - ratelimit <[player]> 10s
        - narrate "<&d>Triggered netblock connection at <[trigger].round_down>" targets:<[player]>
        - narrate "<&e>This connection has no function configured!" targets:<[player]>
        - narrate "<&a>Set a function using the connected netblock at <[netblock].round_down>" targets:<[player]>

# Very simple example functions that run when a player enters or moves inside a netblock connection
#
# I plan to come back to this once I have time for it and allow configuring and passing through function defs to functions from the netblock.
# For now, netblock connections pass the following defs to all functions:
    #   trigger: the LocationTag of the connection that was triggered
    #   player: the PlayerTag of the player that triggered the connection
    #   netblock: the LocationTag of the netblock that the connection is connected to
    #   function: the script name of the function that is being run

## Example of planned definable effect application
nbf_effect_nbdata:
  type: task
  definitions: player|effect|power|duration
  script:
    - cast <[effect].if_null[SPEED]> duration:<[duration].if_null[3s]> amplifier:<[power].if_null[0]> <[player]>

## Examples of static effect application.
# Still useful if you have a use case in mind and would like to have a static effect available for using across many areas/netblocks.
nbf_effect_speed:
  type: task
  definitions: player
  script:
    - cast speed duration:10t amplifier:1 <[player]>

## A few more examples of simple netblock functions
nbf_util_playsound:
  type: task
  definitions: player
  script:
    - playsound <[player].location> sound:entity_axolotl_idle_air pitch:0.1 volume:0.3

nbf_util_secrettp:
  type: task
  definitions: player|trigger
  script:
    - if <[player].has_flag[flag]>:
      - teleport <[player]> <[trigger].add[2,0,0]> relative

nbf_fun_dancefloor:
    type: task
    definitions: trigger|player
    script:
    - ratelimit <[player]> 1t
    - random:
        - define material <material[red_concrete]>
        - define material <material[orange_concrete]>
        - define material <material[yellow_concrete]>
        - define material <material[lime_concrete]>
        - define material <material[cyan_concrete]>
        - define material <material[purple_concrete]>
        - define material <material[pink_concrete]>
        # add more!
    - showfake <[material]> <[trigger].below[1]> players:<server.online_players> duration:3s

nbf_util_zap:
  type: task
  definitions: player
  script:
    - hurt 1 <[player]>
    - playeffect at:<[player].eye_location.below[1]> effect:spark quantity:5 offset:1
