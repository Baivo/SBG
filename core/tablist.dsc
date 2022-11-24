# Good to know:
# You can flag players with "nickname:CustomNickName" (CustomNickName being an actual nickname)
# and it'll be automatically used in the tab

interface_tab_data:
  type: data
  debug: false
  ## Edit the header and footer of player's tab here.
  ## Both supports:
  # - <[online]> (amount of online players, an integer)
  # - <[players]> (automaticaly replace "player" with "players" if there's more than 1 online player,
  # -             those words are editable in the next part of the config)
  # - <[tps]> (server's current tps)
  # - <[ping]> (players current ping, individually)
  # - all kinds of tags like procedures for gradients or anything else
  # - that you'd need that doesn't requires to be per player
  header:
  - <empty>
  - <&[tab_dark]><&l>» <&color[#23b857]><&o>smp.stoneburnergaming.com <&[tab_dark]><&l>«
  - <&color[#7289da]>discord.io/stoneburner
  - <empty>
  footer:
  - <empty>
  - <&color[#bfbfbf]>x <&color[#d65c5c]><[p].location.block.x>   <&color[#bfbfbf]>y <&color[#5cd699]><[p].location.block.y>   <&color[#bfbfbf]>z <&color[#5cb8d6]><[p].location.block.z>
  - <empty>
  - <&color[#23b8ac]>Ping: <&e><[ping]> <&color[#23b8ac]>Server TPS: <&e><[tps]>
  - <&color[#23b8ac]>World View Distance: <&e><[p].location.world.view_distance>
  ## "player(s)" word in the tab, for translation purpose
  # - automaticaly become plural if there's more than 1 online player
  players:
    singular: player
    plural: players
  server_tps:
    perfect_20:
      if_more_than: 19.97
      display: 20
    good_20:
      if_more_than: 19.85
      display: 20
  ## Do you want to use chat prefix and suffix in the tab name?
  ## If false, white player names will be used (Minecraft's default format)
  enable_prefix_suffix: true
  ## Do you want the tablist to be organized depending on player's permission groups?
  ## If "false", it will be organized alphanumericaly by players name (Minecraft's default order)
  ## If "true", it is required that you set the order in the next config key including all
  ##            permission groups. It always takes the highest group in the list if the player has mulitple.
  ##            All unspecified groups will be ordered as if they were set to "ZZZ"
  # - Tested using luckperms and vault, it may or may not work with other permission plugins.
  enable_group_order: true
  ## Here you can put the logic you want but i'll be ordered alphanumericaly: AAA or 000 will come before ZZZ or 999
  #- Generaly using only the letter of the alphabet should be enough and best the way to go except if you have a ridiculous number of ranks
  #- Note that is should be the EXACT name of the group, not group name set in the permission plugin not the chat prefix.
  group_order:
    A: admin
    B: wildcard
    C: trusted
    D: member
    E: default
#
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## ~~~~~~~~~~~~~~~~~~~~~~~~ CONFIG END ~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ##
#
interface_tab_world:
  type: world
  debug: false
  events:
    after player joins:
    - inject interface_tab_updater
    after player quits:
    - inject interface_tab_updater
    after delta time secondly every:1:
    - repeat 10:
      - inject interface_tab_updater
      - wait 2t
interface_tab_updater:
  type: task
  debug: false
  script:
  - stop if:<server.online_players.is_empty>
  - foreach <server.online_players> as:p:
    - adjust <[p]> tab_list_info:<proc[interface_tab_maker].context[<[p]>]>
    - team name:<proc[interface_tab_list_name].context[<[p]>]> add:<[p]>
    - adjust <[p]> player_list_name:<script[interface_tab_data].data_key[enable_prefix_suffix].if_true[<[p].chat_prefix.parse_color><[p].flag[nickname].if_null[<[p].name>]><[p].chat_suffix.parse_color>].if_false[<[p].flag[nickname].if_null[<[p].name>]>]>
interface_tab_maker:
  type: procedure
  debug: false
  definitions: p
  script:
  - define tps <proc[interface_server_tps]>
  - define ping <[p].ping>
  - define online <server.online_players.size>
  - if <[online].is[more].than[1]>:
    - define players <script[interface_tab_data].data_key[players.plural]>
  - else:
    - define players <script[interface_tab_data].data_key[players.singular]>
  - determine <script[interface_tab_data].parsed_key[header].separated_by[<&nl>]>|<script[interface_tab_data].parsed_key[footer].separated_by[<&nl>]>
interface_tab_list_name:
  type: procedure
  debug: false
  definitions: p
  script:
  - if <script[interface_tab_data].data_key[enable_group_order]>:
    - foreach <script[interface_tab_data].data_key[group_order].keys.alphanumeric> as:G:
      - if <[p].groups.contains[<script[interface_tab_data].data_key[group_order].get[<[G]>]>]>:
        - determine <[g]>
  - determine ZZZ
interface_server_tps:
  type: procedure
  debug: false
  script:
  - define tps <server.recent_tps.average>
  - if <[tps]> > <script[interface_tab_data].data_key[server_tps.perfect_20.if_more_than]>:
    - determine <script[interface_tab_data].data_key[server_tps.perfect_20.display]>
  - else if <[tps]> > <script[interface_tab_data].data_key[server_tps.good_20.if_more_than]>:
    - determine <script[interface_tab_data].data_key[server_tps.good_20.display]>
  - else:
    - determine <server.recent_tps.average.round_up_to_precision[0.01]>
