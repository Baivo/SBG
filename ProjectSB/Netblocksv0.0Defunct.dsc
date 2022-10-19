netblock:
    type: world
    debug: true
    events:
        on player places block:
            - if <context.item_in_hand.has_custom_model_data> && ( <context.material.name> = waxed_weathered_copper ):
                - flag <context.location.center> netblock
                - flag <context.location.center.above[1]> netblock
                - flag <context.location.center.above[2]> netblock
        on player breaks block location_flagged:netblock:
            - foreach <context.location.center.list_flags> as:flag:
                - flag <context.location.center> <[flag]>:!
                - flag <context.location.center.above[1]> <[flag]>:!
                - flag <context.location.center.above[2]> <[flag]>:!
            - determine NOTHING passively

netblockitem:
  type: item
  material: waxed_weathered_copper
  display name: <&2><&l>Net Block ^2
  lore:
  - <&[lore]><&gradient[from=<&a>;to=<&7>]><&o>I only knew you for a while
  - <&[lore]>
  - <&[lore]><&gradient[from=<&a>;to=<&7>]><&o>I never saw your smile
  - <&[lore]>
  - <&[lore]><&gradient[from=<&a>;to=<&7>]><&o>Till it was time to go
  - <&[lore]>
  - <&[lore]><&gradient[from=<&a>;to=<&7>]><&o>Time to go away
  mechanisms:
    custom_model_data: 17
  recipes:
    1:
      type: shapeless
      input: <item[barrier]>|<item[observer]>

nbdetect:
  type: world
  events:
    on player walks location_flagged:netblock:
    - ratelimit <player> 2t
    - run nbfence def.loc:<context.new_location.center> def.oldloc:<context.old_location> def.player:<player>

nbfence:
  type: task
  definitions: loc|oldloc|player
  script:
    - ratelimit <[player]> 1s
    - playeffect at:<[loc].above[0.5]> effect:WAX_OFF offset:0.5,0.5,0.5 quantity:5
    - playsound <[loc]> sound:ENCHANT_THORNS_HIT volume:0.5 pitch:1.3
    - flag <[player]> nbfence expire:1s
    - kill <[player]>
    - playsound <[player].location> <[player]> sound:custom:amogus custom volume:0.2
    - define number <util.random.int[1].to[999]>
    - random:
      # - define message "<player.nameplate> was detected in a restricted area."
      - define message "<player.nameplate> attempted to enter a restricted area without clearance. This attempt was stopped by <[number]> high calibre rounds."
      # - define message "<player.nameplate> has been voluntarily enrolled into the BIVCO organ donation program."
      # - define message "<player.nameplate> encountered the consequences of their own actions."
    - define name R.O.S.A
    - define pfp https://i.imgur.com/tF0YpRj.png
    - run discordpost def.message:<[message]> def.name:<[name]> def.pfp:<[pfp]>

nbfencedeath:
  type: world
  events:
    on player dies:
      - if <player.has_flag[nbfence]>:
        - determine passively NO_MESSAGE
        - announce "<player.nameplate> attempted to enter a restricted area"


nbdebug:
  type: task
  definitions: loc
  script:
    - ratelimit <player> 1s
    - debugblock <[loc]> color:0,255,0 players:<[loc].find_players_within[32]> d:25t
    - debugblock <[loc].above[1]> color:0,255,0 players:<[loc].find_players_within[32]> d:25t

discordpost:
    type: task
    definitions: message|name|pfp
    script:
    - define url https://discord.com/api/webhooks/1019219729149337660/Th4X0NAvpQSV_4V3bjAYoYxg4ZeK3ybe4kYIxPIgJdsGxwRuPR9zcdr3pI93JyVWb4tE
    - if <[name].equals[name]>:
        - define user Wah
    - else:
        - define user <[name]>
    - if <[pfp].equals[pfp]>:
        - define pic https://i.imgur.com/xYsX0An.png
    - else:
        - define pic <[pfp]>
    - define data '{"content": "<[message]>","username": "<[user]>","avatar_url": "<[pic]>","tts": "false"}'
    - webget <[url]> data:<[data]> headers:<map.with[Content-Type].as[application/json]>
