# Author: Baivo
# Version 1.0

# Starting point for an independent point based reward system. Will eventually expand outside MC. 
# Points are rewarded per player for each minute played, but given in 10-minute intervals. 
# Lots of potential, expect this to expand a fair bit over time. 

SP_start:
    type: world
    events:
        on player joins:
        - if !<player.has_flag[SP_balance]>:
            - flag <player> SP_balance:0
        - else:
            - flag <player> SP_balance:<player.flag[SP_balance]>

SP_clock:
    type: world
    events:
        on delta time minutely:
        - foreach <server.online_players> as:player:
            - define SP_balance <[player].flag[SP_balance]>
            - if !<[player].has_flag[SP]>:
                - flag <[player]> SP:1
            - else if <[player].flag[SP]> >= 9:
                - flag <[player]> SP:1
                - flag <[player]> SP_balance:+:10
                - actionbar "<&7>You earned <&e>10 SP <&7>for 10 minutes online time" targets:<[player]>
            - else if <[player].flag[SP]> <= 9:
                - flag <[player]> SP:++

spoints_command:
    type: command
    name: spoints
    debug: false
    description: Adjust second currency
    usage: /spoints action player amount
    permisison: spoints.admin
    tab completions:
        1: add|remove|set|get|list
        2: <server.online_players.parse[name]>
        3: 10|20|30|40|50|60|70|80|90|100
    script:
    - if !<context.args.get[1]> != list:
        - if !<server.online_players.formatted.contains[<context.args.get[2]>]>:
            - narrate "<&c>Player not found!"
            - stop
    - if !<context.args.get[3].is_integer>:
        - narrate "<&c>Amount must be a number!"
    - else:
        - define player <player[<context.args.get[2]>]>
    - if <context.args.get[1]> == add:
        - flag <[player]> SP_balance:+:<context.args.get[3]>
        - narrate "<&e>Added <&a><context.args.get[3]> <&e>to <[player].display_name><&e>'s SP balance!"
        - narrate "<&e>They now have <&a><[player].flag[SP_balance]> <&e>SP!"
        - narrate "<&a><context.args.get[3]><&e> has been added to your server point balance!" targets:<player[<[player]>]>
    - if <context.args.get[1]> == remove:
        - flag <[player]> SP_balance:-:<context.args.get[3]>
        - narrate "<&e>Removed <&c><context.args.get[3]> <&e>from <[player].display_name><&e>'s SP balance!"
        - narrate "<&e>They now have <&a><[player].flag[SP_balance]> <&e>SP!"
        - narrate "<&c><context.args.get[3]><&e> has been removed from your server point balance!" targets:<player[<[player]>]>
    - if <context.args.get[1]> == set:
        - flag <[player]> SP_balance:<context.args.get[3]>
        - narrate "<&e>Set <[player].display_name><&e>'s SP balance to <&a><context.args.get[3]><&e>!"
        - narrate "<&e>Your server point balance has been set to <[player].flag[SP_balance]>!" targets:<player[<[player]>]>
    - if <context.args.get[1]> == get:
        - narrate "<&e><[player].display_name><&e>'s SP balance is <&a><[player].flag[SP_balance]><&e>!"
    - if <context.args.get[1]> == list:
        - narrate "<&e>Server Point Balances:<&nl>"
        - foreach <server.online_players> as:player:
            - narrate <[player].display_name><&sp><&7><&gt><&sp><&a><[player].flag[SP_balance]>
