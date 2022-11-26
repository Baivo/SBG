infobot_setup:
    type: task
    definitions: npc|player
    script:
        - narrate "<&a><[npc]>created.<&nl><&7>Use /infobot setline [1-5]"
        - announce to_flagged:Baivo <[npc]>
        # Adjust these lines to edit the default hologram lines
        - define line1 "Line 1"
        - define line2 "Line 2"
        - define line3 "Line 3"
        - define line4 "Line 4"
        - define line5 "Line 5"
        # Do not edit below this line
        - define lines <list[<[line1]>|<[line2]>|<[line3]>|<[line4]>|<[line5]>]>
        - flag <[npc]> infobot
        - flag <[npc]> infobotpage:0
        - flag <[npc]> infobotlocation:<context.entity.location>
        - flag <[player]> infobotselected:<[npc]> expire:30m
        # Adjust these lines to change the default mechanisms for the info-bot npc
        - adjust <[npc]> name_visible:false
        - adjust <[npc]> is_small:true
        - adjust <[npc]> invulnerable:true
        - adjust <[npc]> visible:false
        - adjust <[npc]> hologram_lines:<[lines]>
        # Adjust this value to change the line formatting for the holograms.
        # Changing this enough will show the lines in reverse i.e. line 5 on top, line 1 on bottom, so you may need to flip their order.
        - adjust <[npc]> hologram_line_height:-0.3
        # Do not edit below this line
        - run infobot_menu def.ib:<[npc]>

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
    # few of these if statements need to be combined
    - if !<context.args.any>:
        - narrate "<&e>Usage: /infobot <&6>search/create/setline"
        - stop
    - if search|create|setline !contains <context.args.get[1]>:
        - narrate "<&e>Usage: /infobot <&6>search/create/setline"
    - choose <context.args.get[1]>:
        - case search:
            - define infobots <list>
            - foreach <player.location.find_npcs_within[32]> as:npc:
                - if <[npc].has_flag[infobot]>:
                    - define infobots:->:<[npc]>
                - else:
                    - foreach next
            - if <[infobots].any>:
                - narrate "<&nl><&3>Found the following Info-Bots:<&nl>"
                - foreach <[infobots]> as:infobot:
                    - run infobot_menu def.ib:<[infobot]>
            - else:
                - narrate "<&c> No infobots found near your location!"
        - case create:
            - create armor_stand Info-Bot <player.location> save:infobotnpc
            - define npc <entry[infobotnpc].created_npc>
            - actionbar "<&a>Created Info-bot <&6><[npc]><&a> at <&6><player.location.center>"
            - run infobot_setup def.npc:<[npc]> def.player:<player>
        - case setline:
            - define selectedinfobot <player.flag[infobotselected]>
            - if !<[selectedinfobot].is_npc>:
                - narrate "<&c><&o>No info-bot selected. Please use /infobot search to select an info-bot to edit"
                - stop
            - if 1|2|3|4|5 !contains <context.args.get[2]>:
                - narrate "<&c><&o>Please choose lines 1-5 to set the display"
                - stop
            - if <context.args.size> <= 2:
                - define input <&n>
            - else:
                - define input <element[<context.args.get[3].to[last].separated_by[<&sp>]>]>
            - define linelist <npc[<[selectedinfobot].id>].hologram_lines>
            - define updatelist <[linelist].set_single[<[input]>].at[<context.args.get[2]>]>
            - adjust <[selectedinfobot]> hologram_lines:<[updatelist]>

infobot_menu:
    type: task
    definitions: ib
    script:
        - clickable save:clickable<[ib].id> until:5m:
            - teleport <player> <[ib].location.center>
        #
        - clickable save:remove<[ib].id> until:5m:
            - remove <[ib]>
            - narrate "<&c>Info-bot <&6><[ib].id><&c> has been deleted"
        #
        - clickable save:select<[ib].id> until:5m:
            - flag <player> infobotselected:<[ib]> expire:30m
            - narrate "<&d>Info-bot <&6><[ib].id><&d> has been selected"
        #
        - clickable save:teleport<[ib].id> until:5m:
            - teleport <[ib]> <player.location.center>
            - narrate "<&3>Info-bot <&6><[ib].id><&3> teleported to your location"
        - define teleport "[Teleport here]"
        - define remove "[Remove Info-Bot]"
        - define select "[Select this Info-Bot]"
        - define hover "<&3><&o>Click to teleport in spectator mode"
        - narrate "<&8><&l><&gt> <&a><&l><[ib].id><&7> located <&hover[<[hover]>].type[SHOW_TEXT]><&6><element[<[ib].location.simple.formatted>].on_click[<entry[clickable<[ib].id>].command>]><&end_hover>"
        - narrate <&d><element[<[select]>].on_click[<entry[select<[ib].id>].command>]><&sp><&3><element[<[teleport]>].on_click[<entry[teleport<[ib].id>].command>]><&c><&sp><element[<[remove]>].on_click[<entry[remove<[ib].id>].command>]><&nl>
