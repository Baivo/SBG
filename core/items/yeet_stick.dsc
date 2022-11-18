# The yeet stick, a fun little item smashed out in an hour with a random newbie who never joined back

yeet_command:
  type: command
  debug: false
  name: yeet
  description: Yeet
  usage: /yeet
  script:
    - playeffect at:<player.location.above[1]> effect:cloud quantity:15 offset:2
    - push <player> destination:<player.location.forward[100]> speed:5 duration:3t
    - repeat 20:
        - playeffect at:<player.location.above[1]> effect:cloud quantity:3 offset:0.3
        - wait 1t

yeet_stick:
    type: item
    display name: <&color[#f5b7b1]>The Yeet Stick
    material: stick
    lore:
    - <&color[#13baba]>Right click to yeet
    - <&sp>
    - <&color[#fff176]><&o>Sponsored by Starburst926
    mechanisms:
        custom_model_data: 17
    recipes:
        1:
            type: shapeless
            input: <item[stick]>|<item[feather]>

yeet_event:
    type: world
    events:
        on player right clicks block with:yeet_stick:
            - playeffect at:<player.location.above[1]> effect:cloud quantity:15 offset:2
            - push <player> destination:<player.location.forward[100]> speed:5 duration:1t no_damage no_rotate
            - flag <player> yeet expire:30s
            - repeat 20:
                - playeffect at:<player.location.above[1]> effect:cloud quantity:3 offset:0.3
                - wait 1t
        on player dies cause:FALL:
        - if <player.has_flag[yeet]>:
            - narrate "<&f><player.display_name> tried to yeet, but landed hard on their feet." targets:<server.online_players>
            - determine NO_MESSAGE
