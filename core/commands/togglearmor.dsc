Toggle_Armour_Command:
    type: command
    name: togglearmour
    description: Hide or show your armour
    usage: /togglearmour
    script:
    - if <player.has_flag[armouroff]>:
        - flag <player> armouroff:!
    - else:
        - flag <player> armoroff
    - run toggle_armour_script def.player:<player>

toggle_armour_script:
    type: task
    definitions: player
    script:
    - if !<player.has_flag[armouroff]>:
        - fakeequip <player> for:<server.online_players> reset
    - else:
        - if ( <player.inventory.slot[chest]> == elytra ) || ( <player.inventory.slot[chest]> == leather ):
            - fakeequip <player> for:<server.online_players> head:air legs:air feet:air
        - else:
            - fakeequip <player> for:<server.online_players> head:air chest:air legs:air feet:air

toggle_armour_events:
    type: world
    events:
        on player joins:
        - foreach <server.online_players> as:player:
            - if <[player].has_flag[armouroff]>:
                - run toggle_armour_script def.player:<[player]>