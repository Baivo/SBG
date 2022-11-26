infobot_command:
    type: command
    name: infobot
    debug: false
    description: Create and manage infobots!
    usage: /infobot
    permission: B1V.infobot
    permission message: Insufficient permissions, likely a skill issue. Please submit your complaints via your nearest AusPost provider to ensure we'll never read it.
    tab completions:
        1: search|create|setline
        2: 1|2|3|4|5
    script:
    - if <context.args.get[1]> == search:
        - define infobots <list>
        - define npclist <player.location.find_npcs_within[32]>
        - foreach <[npclist]> as:current:
            - if <npc[<[current]>].has_flag[infobot]>:
                - define infobots:->:<[current]>
            - else:
                - foreach next
        - if <[infobots].any>:
            - narrate "<&nl><&b>Found the following Info-Bots:<&r><&nl>"
            - foreach <[infobots]> as:ib:
                - run infobot_menu def.ib:<[ib]>
        - else:
            - narrate "<red> No infobots found near your location!"
# create a new info-bot
    - if <context.args.get[1]> == create:
        - create armor_stand Info-Bot <player.location> save:infobot
        - define npc <entry[infobot].created_npc>
        - wait 1t
        - actionbar "<&a>Created Info-bot <&6><[npc]><&a> at <&6><player.location.center>"
        - run infobot_setup def.npc:<[npc]> def.player:<player>
# set the display info manually for an infobot
    - if <context.args.get[1]> == setline:
        - define sib <player.flag[infobotselected]>
        - if <[sib].is_npc> !=:
            - narrate "<red><italic>No info-bot selected. Please use /infobot search to select an info-bot to edit"
            - determine cancelled
        - if <context.args.get[2].contains_any[1|2|3|4|5]> !=:
            - narrate "<red><italic>Please choose lines 1-5 to set the display"
            - determine cancelled
        - if <context.args.size> <= 2:
            - define input &r
        - else:
            - define input <element[<context.args.get[3].to[last].separated_by[<&sp>]>]>
        - define linelist <npc[<[sib].id>].hologram_lines>
        - define updatelist <[linelist].set_single[<[input]>].at[<context.args.get[2]>]>
        - adjust <[sib]> hologram_lines:<[updatelist]>

infobot_setup:
    type: task
    definitions: npc|player
    script:
        - narrate "<&a><[npc]>created.<&nl><&7>Use /infobot setline [1-5] [line text]"
        - define lines <list["Line 1"|"Line 2"|"Line 3"|"Line 4"|"Line 5"]>
        - flag <[npc]> infobot
        - flag <[player]> infobotselected:<[npc]> expire:30m
        - adjust <[npc]> <map[name_visible=false;is_small=true;invulnerable=true;visible=false;hologram_lines=<[lines]>;hologram_line_height=-0.3]>
        - run infobot_menu def.ib:<[npc]>

infobot_menu:
    type: task
    definitions: ib
    script:
        - clickable save:clickable<[ib].id> until:5m:
            - adjust <player> gamemode:spectator
            - teleport <player> <[ib].location.center>
        - clickable save:remove<[ib].id> until:5m:
            - remove <[ib]>
            - narrate "<red>Info-bot <&6><[ib].id><red> has been deleted"
        - clickable save:select<[ib].id> until:5m:
            - flag <player> infobotselected:<[ib]> expire:30m
            - narrate "<&d>Info-bot <&6><[ib].id><&d> has been selected"
        - clickable save:teleport<[ib].id> until:5m:
            - teleport <[ib]> <player.location.center>
            - narrate "<&3>Info-bot <&6><[ib].id><&3> teleported to your location"
        - define teleport "[Teleport here]"
        - define remove "[Remove Info-Bot]"
        - define select "[Select this Info-Bot]"
        - define hover "<&3><italic>Click to teleport in spectator mode"
        - narrate "<&8><&l><&gt> <&a><&l><[ib].id><gray> located <&hover[<[hover]>].type[SHOW_TEXT]><&6><element[<[ib].location.simple>].on_click[<entry[clickable<[ib].id>].command>]><reset><&end_hover>"
        - narrate "<&d><element[<[select]>].on_click[<entry[select<[ib].id>].command>]><reset> <&3><element[<[teleport]>].on_click[<entry[teleport<[ib].id>].command>]><reset><red> <element[<[remove]>].on_click[<entry[remove<[ib].id>].command>]><reset><&nl>"

