# Author: Baivo#1337

### NETBLOCK BLOCK EVENTS ###
netblock_events_netblocks:
    type: world
    debug: false
    events:
        # Sets up a netblock at the location
        on player places netblock_item_netblock:
        - define netblock <context.location>
        - flag server Netblock.<[netblock]>.connections:<list[]>
        - flag server Netblock.<[netblock]>.function:nbf_getstarted
        - flag server Netblock.<[netblock]>.owner:<player>
        - flag <[netblock]> netblock:<server.flag[netblock.<[netblock]>]>
        - actionbar "<&7>Created netblock at: <&color[#bfbfbf]>x <&color[#d65c5c]><[netblock].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[netblock].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[netblock].round_down.z>"
        # Clears the netblock at the location and it's connections
        on player breaks block location_flagged:netblock:
        - define netblock <context.location>
        - flag server Netblock.<[netblock]>:!
        - flag <[netblock]> netblock:!
        - actionbar "<&7>Removed netblock at: <&color[#bfbfbf]>x <&color[#d65c5c]><[netblock].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[netblock].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[netblock].round_down.z>"
        - determine nothing

### CONNECTION TRIGGER EVENT ###
netblock_events_connectionTrigger:
    type: world
    debug: false
    events:
        on player walks location_flagged:connection:
        - ratelimit <player> 1t
        - define connection <context.new_location>
        - define netblock <[connection].flag[connection]>
        - define function <server.flag[netblock.<[netblock]>.function]>
        - run <[function]> def.player:<context.player> def.trigger:<[connection]> def.netblock:<[netblock]> def.function:<[function]>

### CONFIGURATOR EVENTS ###
netblock_events_configurator:
    type: world
    debug: false
    events:
        # Sets the currently active netblock for use with the configurator
        on player right clicks block location_flagged:netblock with:netblock_item_configurator:
        - define netblock <context.location>
        - inventory adjust d:<player.inventory> slot:hand flag:currentNetblock:<[netblock]> expire:1h
        - actionbar "<&7>Configurator set to netblock at: <&color[#bfbfbf]>x <&color[#d65c5c]><[netblock].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[netblock].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[netblock].round_down.z>"
        - determine passively cancelled

        # Prompts the player to adjust features of the currently active netblock
        on player left clicks block location_flagged:netblock with:netblock_item_configurator:
        - define netblock <context.location>
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
            - foreach <server.flag[Netblock.<[netblock]>.connections]> as:connection:
                - narrate "<&7>- <&color[#bfbfbf]>x <&color[#d65c5c]><[connection].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[connection].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[connection].round_down.z>"
                - debugblock <[connection]> color:0,255,0 players:<player> d:60t
        # Clickable to clear netblock connections
        - define clearconnections "<&c>[Clear Connections]<&7>"
        - clickable save:connectionclear:
            - flag server Netblock.<[netblock]>.connections:<list[]>
            - narrate "<&7>Removed all connections for this netblock."
        # Construct the chat menu and send it to the player
        - narrate "<&7>Configuring netblock at: <&color[#bfbfbf]>x <&color[#d65c5c]><[netblock].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[netblock].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[netblock].round_down.z>"
        - narrate "<&7>Current function: <&color[#bfbfbf]><server.flag[netblock.<[netblock]>.function]>"
        - narrate <element[<[functionset]>].on_click[<entry[functionset].command>]><&sp><&sp><element[connectionlist].on_click[<entry[connectionlist].command>]><&sp><&sp><element[connectionclear].on_click[<entry[connectionclear].command>]>

        # Adds a connection to the currently active netblock if the player is not sneaking
        # Removes a connection from the currently active netblock if the player is sneaking
        on player right clicks !air with:netblock_item_configurator:
        - define netblock <player.item_in_hand.flag[currentNetblock]>
        - define connection <context.relative>
        - if !<player.is_sneaking>:
            - flag server Netblock.<[netblock]>.connections:->:<[connection]>
            - flag <[connection]> connection:<[netblock]>
            - actionbar "<&7>Created new connection at: <&color[#bfbfbf]>x <&color[#d65c5c]><[connection].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[connection].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[connection].round_down.z>"
        - else:
            - flag server Netblock.<[netblock]>.connections:<server.flag[Netblock.<[netblock]>.connections].exclude[<[connection]>]>
            - flag <[connection]> connection:!
            - actionbar "<&7>Removed connection at: <&color[#bfbfbf]>x <&color[#d65c5c]><[connection].round_down.x>  <&color[#bfbfbf]>y <&color[#5cd699]><[connection].round_down.y>  <&color[#bfbfbf]>z <&color[#5cb8d6]><[connection].round_down.z>"
        - determine passively cancelled

        # Shows the currently active netblock and it's connections using debug blocks
        on player left clicks air with:netblock_item_configurator:
        - define netblock <player.item_in_hand.flag[currentNetblock]>
        - debugblock <[netblock]> color:0,0,0 players:<player> d:60t
        - foreach <server.flag[Netblock.<[netblock]>.connections]> as:connection:
            - debugblock <[connection]> color:0,255,0 players:<player> d:60t


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
            - flag server Netblock.<[netblock]>.function:<[function]>
            - narrate "<&a>Netblock function set to: <&e><[function]>"
            - flag <player> netblock:!
        - determine cancelled

### ITEMS ###
netblock_item_configurator:
  type: item
  material: spectral_arrow
  display name: <&color[#5fc2a9]>Netblock Configurator
  lore:
  - <&gradient[from=<&d>;to=<&b>]>ダンスフロア
  - <&color[#357541]>█<&color[#c2a8ff]><&o> Netblock clicks<&co>
  - <&color[#357541]>█<&color[#73bd81]><&o> Left click to set configurator to netblock
  - <&color[#357541]>█<&color[#73bd81]><&o> Right click to open netblock menu
  - <&color[#357541]>█<&color[#c2a8ff]><&o> Clicking while configured to netblock<&co>
  - <&color[#357541]>█<&color[#73bd81]><&o> Right click to place a connection
  - <&color[#357541]>█<&color[#73bd81]><&o> Sneak & right click to remove a connection
  - <&color[#357541]>█<&color[#73bd81]><&o> Left click to show netblock connections
  mechanisms:
    custom_model_data: 18
  recipes:
    1:
      type: shapeless
      input: <item[barrier]>|<item[arrow]>

netblock_item_netblock:
  type: item
  material: waxed_weathered_copper
  display name: <&gradient[from=<&7>;to=<&color[#357541]>]>Net Block
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

### SCRIPTS ###
# Placeholder netblock function script to demonstrate use and passing definitions
nbf_getstarted:
    type: task
    definitions: trigger|player|netblock
    script:
        - narrate "<&d>Triggered netblock connection at <[trigger].round_down>" targets:<[player]>
        - narrate "<&e>This connection has no function configured!" targets:<[player]>
        - narrate "<&a>Set a function using the connected netblock at <[netblock].round_down>" targets:<[player]>
