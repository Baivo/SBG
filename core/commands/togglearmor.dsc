Toggle_armor_Command:
    type: command
    name: togglearmor
    description: Hide or show your armor
    usage: /togglearmor
    aliases:
    - ta
    - togglearmour
    - hidearmor
    - hidearmour
    - showarmor
    - showarnour
    script:
    - if <player.has_flag[armoroff]>:
        - flag <player> armoroff:!
        - narrate "<&a>Armor is now visible"
    - else:
        - flag <player> armoroff
        - narrate "<&e>Armor is now hidden"
    - run toggle_armor_script def.player:<player>

toggle_armor_script:
    type: task
    definitions: player
    script:
    - if !<player.has_flag[armoroff]>:
        - fakeequip <player> for:<server.online_players> reset
    - else:
        - if ( <player.inventory.slot[chest].material.name> == elytra ) || ( <player.inventory.slot[chest].material.name> == leather ):
            - fakeequip <player> for:<server.online_players> head:air legs:air feet:air
        - else:
            - fakeequip <player> for:<server.online_players> head:air chest:air legs:air feet:air

toggle_armor_events:
    type: world
    events:
        on player joins:
        - foreach <server.online_players> as:player:
            - if <[player].has_flag[armoroff]>:
                - run toggle_armor_script def.player:<[player]>