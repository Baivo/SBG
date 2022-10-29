# 

# infocommand:
#     type: command
#     name: infobot
#     debug: true
#     description: Internal Info-Bot Command
#     usage: /infobot Internal Development Command
#     permission: B1V.infobot
#     permission message: Oi mate. I know you're a tool, but that doesn't mean you can hang out with mine as well.
#     tab completions:
#         1: search|create|setline|blankline
#     script:
#     - if <context.args.get[1]> == search:
#         - define infobots <list>
#         - define npclist <player.location.find_npcs_within[32]>
#         - foreach <[npclist]> as:current:
#             - if <npc[<[current]>].has_flag[infobot]>:
#                 - define infobots:->:<[current]>
#             - else:
#                 - foreach next
#         - if <[infobots].any>:
#             - narrate " "
#             - narrate "<blue>Found the following Info-Bots:<reset>"
#             - define hover "<dark_aqua><italic>Click to teleport in spectator mode"
#             - narrate " "
#             - foreach <[infobots]> as:ib:
#                 - clickable save:clickable<[ib].id> until:5m:
#                     - adjust <player> gamemode:spectator
#                     - teleport <player> <[ib].location.center>
#                 #
#                 - clickable save:remove<[ib].id> until:5m:
#                     - remove <[ib]>
#                     - narrate "<red>Info-bot <gold><[ib].id><red> has been deleted"
#                 #
#                 - clickable save:select<[ib].id> until:5m:
#                     - flag <player> infobotselected:<[ib]> expire:30m
#                     - narrate "<light_purple>Info-bot <gold><[ib].id><light_purple> has been selected"
#                 #
#                 - clickable save:teleport<[ib].id> until:5m:
#                     - teleport <[ib]> <player.location.center>
#                     - narrate "<dark_aqua>Info-bot <gold><[ib].id><dark_aqua> teleported to your location"
#                 - define teleport "[Teleport here]"
#                 - define remove "[Remove Info-Bot]"
#                 - define select "[Select this Info-Bot]"
#                 - narrate "<&8><&l><&gt> <&a><&l><[ib].id><gray> located <&hover[<[hover]>].type[SHOW_TEXT]><gold><element[<[ib].location.simple>].on_click[<entry[clickable<[ib].id>].command>]><reset><&end_hover>"
#                 - narrate "<light_purple><element[<[select]>].on_click[<entry[select<[ib].id>].command>]><reset> <dark_aqua><element[<[teleport]>].on_click[<entry[teleport<[ib].id>].command>]><reset><red> <element[<[remove]>].on_click[<entry[remove<[ib].id>].command>]><reset><&nl>"
#         - else:
#             - narrate "<red> No infobots found near your location!"
# # create a new info-bot
#     - if <context.args.get[1]> == create:
#         - create armor_stand Info-Bot <player.location> save:infobot
#         - define npc <entry[infobot].created_npc>
#         - narrate "<&a>Created Info-bot <&6><[npc]><&a> at <&6><player.location.center>"
#         - flag <player> infobotselected:<[npc]> expire:30m
#         - run info_bot_setup def.npc:<[npc]>
# # set the display info manually for an infobot
#     - if <context.args.get[1]> == setline:
#         - define sib <player.flag[infobotselected]>
#         - if <[sib].is_npc> !=:
#             - narrate "<red><italic>No info-bot selected. Please use /infobot search to select an info-bot to edit"
#             - determine cancelled
#         - if <context.args.get[2].contains_any[1|2|3|4|5]> !=:
#             - narrate "<red><italic>Please choose lines 1-5 to set the display"
#             - determine cancelled
#         - if <context.args.size> <= 2:
#             - define input &r
#         - else:
#             - define input <context.args.get[3].to[last].separated_by[<&sp>]>
#         - define linelist <npc[<[sib].id>].hologram_lines>
#         - define updatelist <[linelist].set_single[<[input].unescaped>].at[<context.args.get[2]>]>
#         - adjust <[sib]> hologram_lines:<[updatelist]>
# # blanks out a line on an info bot
#     - if <context.args.get[1]> == blankline:
#         - define sib <player.flag[infobotselected]>
#         - if <[sib].is_npc> !=:
#             - narrate "<red><italic>No info-bot selected. Please use /infobot search to select an info-bot to edit"
#             - determine cancelled
#         - if <context.args.get[2].contains_any[1|2|3|4|5]> !=:
#             - narrate "<red><italic>Please choose a line between 1-5 to set blank<&nl><&7>Example: /infobot blankline 3"
#             - determine cancelled
#         - define linelist <npc[<[sib].id>].hologram_lines>
#         - define updatelist <[linelist].set_single[&r].at[<context.args.get[2]>]>
#         - adjust <[sib]> hologram_lines:<[updatelist]>
#     - if <context.args.get[1]> == rainbowline:
#         - define sib <player.flag[infobotselected]>
#         - if <[sib].is_npc> !=:
#             - narrate "<red><italic>No info-bot selected. Please use /infobot search to select an info-bot to edit"
#             - determine cancelled
#         - if <context.args.get[2].contains_any[1|2|3|4|5]> !=:
#             - narrate "<red><italic>Please choose a line between 1-5 to set blank<&nl><&7>Example: /infobot blankline 3"
#             - determine cancelled
#         - flag <[sib]> rainbowline<context.args.get[3]>
