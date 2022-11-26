##Water, fire, air and dirt
##Fuckin magnets, how do they work?

#Cool magnet items with player defined range up to an admin defined limit
#When turned on, these will work in a player inventory regardless of slot, even while worn.
#For added utility, placing a magnet in an item frame while turned on will still attract items, making it a great tool to place above a hopper.

## MAGNET ITEMS ##
#Radius determines the default starting radius, maxradius for the highest value the magnet can be adjusted to.
#Magnets can be turned on/off by right clicking.
#Magnet range can be configured by left clicking to open a GUI.
#
#Two examples are provided. As long as you provide a magnet and maxradius flag, changing the two below or adding your own should still work. Probably.

magnet:
  type: item
  material: scute
  display name: <dark_aqua><&l>Item Magnet
  lore:
  - <&[lore]>
  - <&[lore]><aqua>Collects nearby items in a radius
  - <&[lore]>
  - <&[lore]><&a>Right click to toggle on/off
  - <&[lore]>
  - <&[lore]><&e>Left click to change magnet settings
  mechanisms:
    custom_model_data: 17
    hides: ALL
  flags:
    magnet: true
    magnetoff: true
    radius: 1
    maxradius: 16

super_magnet:
  type: item
  material: scute
  display name: <gold><&l>Super Item Magnet
  lore:
  - <&[lore]>
  - <&[lore]><aqua>Collects nearby items in a radius
  - <&[lore]>
  - <&[lore]><&a>Right click to toggle on/off
  - <&[lore]>
  - <&[lore]><&e>Left click to change magnet settings
  mechanisms:
    custom_model_data: 17
    hides: ALL
  flags:
    magnet: true
    magnetoff: true
    radius: 128
    maxradius: 128

## MAGNET GUI AND ON/OFF TOGGLE ##
#I plan on adding player adjustable whitelist/blacklist filters for items affected by each magnet, which will make the GUI look less barren.
#The toggle button is also kind of redundant, but is still an extra indicator for the state of the magnet, so it felt equally redundant to remove it.
#If you don't like the toggle button, I have helpfully highlighted the lines to delete.
magnet_GUI_script:
  type: task
  script:
  - ratelimit <player> 10t
  - define inv <inventory[magnet_gui]>
## DELETE BELOW THIS LINE TO REMOVE THE CONTROVERSIAL TOGGLE BUTTON ##
  - if <player.item_in_hand.has_flag[magneton]>:
    - inventory set d:<[inv]> o:magnet_on slot:1
  - else if <player.item_in_hand.has_flag[magnetoff]>:
    - inventory set d:<[inv]> o:magnet_off slot:1
## STOP DELETING AT THIS LINE TO AVOID BREAKING ANYTHING ELSE, UNLESS YOU'RE INTO THAT. I AM A COMMENT LINE, I CANNOT PHYSICALLY RETALIATE BASED ON YOUR ACTIONS UNTIL MCMONKEY ADDS THAT FEATURE BACK ##
  - inventory set d:<[inv]> o:magnet_close slot:9
  - inventory set d:<[inv]> o:magnet_icon slot:5
  - inventory adjust d:<[inv]> slot:5 "display:<&6>Magnet Power: <&a><&l><player.item_in_hand.flag[radius]>"
  - inventory adjust d:<[inv]> slot:5 "lore:<&6>Max Power: <&c><&l><player.item_in_hand.flag[maxradius]>"
  - inventory set d:<[inv]> o:magnet_up slot:6
  - inventory set d:<[inv]> o:magnet_down slot:4
  - inventory open d:<[inv]>

magnet_handler:
  type: world
  debug: false
  events:
    after player left clicks block with:item_flagged:magnet:
    - run magnet_GUI_script
    - determine cancelled
    after player right clicks block with:item_flagged:magnet:
      - if <player.item_in_hand.has_flag[magneton]>:
        - inventory adjust slot:hand flag:magneton:!
        - inventory adjust slot:hand flag:magnetoff
        - inventory adjust slot:hand remove_enchantments
        - playsound <player.location> <server.online_players> sound:block_beacon_deactivate volume:0.2 pitch:2
        - determine passively cancelled
      - else if <player.item_in_hand.has_flag[magnetoff]>:
        - inventory adjust slot:hand flag:magnetoff:!
        - inventory adjust slot:hand flag:magneton
        - inventory adjust slot:hand enchantments:luck=1
        - playsound <player.location> <server.online_players> sound:block_beacon_activate volume:0.2 pitch:2
        - determine passively cancelled

magnet_gui:
  type: inventory
  inventory: chest
  title: <dark_aqua><bold>Magnet Configuration
  size: 9
  gui: true

magnet_gui_handler:
  type: world
  events:
    after player clicks magnet_close in magnet_gui:
      - inventory close
    after player clicks magnet_off in magnet_gui:
      - if <player.item_in_hand.has_flag[magnet]>:
        - inventory adjust slot:hand flag:magnetoff:!
        - inventory adjust slot:hand flag:magneton
        - narrate "<dark_aqua>Magnet is: <green><bold>ON"
        - inventory adjust slot:hand enchantments:luck=1
        - inventory close
        - run magnet_GUI_script
      - else:
        - inventory close
        - narrate "<&7>You are not currently holding a magnet."
    after player clicks magnet_on in magnet_gui:
      - if <player.item_in_hand.has_flag[magneton]>:
        - inventory adjust slot:hand flag:magneton:!
        - inventory adjust slot:hand flag:magnetoff
        - narrate "<dark_aqua>Magnet is: <red><bold>OFF"
        - inventory adjust slot:hand remove_enchantments
        - inventory close
        - run magnet_GUI_script
      - else:
        - inventory close
        - narrate "<&7>You are not currently holding a magnet."
    after player clicks magnet_up in magnet_gui:
      - define newpower <player.item_in_hand.flag[radius]>
      - define inv <inventory[magnet_gui]>
      - if <player.item_in_hand.flag[radius]> < <player.item_in_hand.flag[maxradius]>:
        - define newpower:++
        - inventory adjust slot:hand flag:radius:<[newpower]>
        - inventory adjust d:<[inv]> slot:5 "display:<&6>Magnet Power: <&a><&l><[newpower]>"
        - run magnet_GUI_script
      - else:
        - narrate "<&7>Your magnet is at maximum power"
        - inventory close
    after player clicks magnet_down in magnet_gui:
      - define newpower <player.item_in_hand.flag[radius]>
      - define inv <inventory[magnet_gui]>
      - if <player.item_in_hand.flag[radius]> >= 1:
        - define newpower:--
        - inventory adjust slot:hand flag:radius:<[newpower]>
        - inventory adjust d:<[inv]> slot:5 "display:<&6>Magnet Power: <&a><&l><[newpower]>"
        - run magnet_GUI_script
      - else:
        - narrate "<&7>Your magnet is at minimum power"
        - inventory close

magnet_close:
  type: item
  material: barrier
  display name: <red>Close this menu

magnet_icon:
  type: item
  material: scute
  display name: test
  mechanisms:
    custom_model_data: 17

magnet_off:
  type: item
  material: red_terracotta
  display name: <red>Magnet is off!
  lore:
    - <&[lore]><&7>Click to turn the magnet on!

magnet_up:
  type: item
  material: soul_torch
  display name: <red>Increase power!
  lore:
    - <&[lore]><&7>Click to increase the collection radius!

magnet_down:
  type: item
  material: redstone_torch
  display name: <red>Decrease power!
  lore:
    - <&[lore]><&7>Click to reduce the collection radius!

magnet_on:
  type: item
  material: lime_terracotta
  display name: <green>Magnet is on!
  lore:
    - <&[lore]><&7>Click to turn the magnet off!

##ACTIVE MAGNET LOGIC ##
#Look, I'll be honest with you. I lost track of how many times I re-wrote what you see below.
#This will likely continue. I learned alot about myself making this stupid script. I could have just left it at finding nearby items and teleporting to them, but no.
#I wanted the items to chase you like that scene from robots, you know the one. With the afro and the dumpster and the springs.
#I may have issues, therapy might be required, but I swear to god the raw power and arousal i felt seeing stupid fucking saplings and sticks floating towards a hopper with a magnet above it was unreal.
#But I equally wanted this to not break a server by using a bunch of relative velocity, raycasting and pathfinding nonsense.
#So far, this is the solution that is closest to how I wanted the behaviour, while hogging as little resources to allow it to scale for many magnets at once.
#More work needs to be done on better re-calculating the best valid target for the items to be attracted to, but these magnets were supposed to take a few hours and i'm on day 9 and i'm currently starting to point north while floating in water.
magnet_proc:
  type: task
  debug: false
  definitions: location | radius
  script:
      - foreach <[location].find_entities[dropped_item].within[<[radius]>]> as:item:
          - define rel <[location].sub[<[item].location>]>
          - adjust <[item]> gravity:false
          - adjust <[item]> velocity:<[rel].normalize.mul[<element[1.5].div[<[rel].length.sqrt>]>]>
          - wait 1t
          - adjust <[item]> gravity:true

magnet_loop_player:
  type: world
  debug: false
  events:
    on delta time secondly every:1:
    - define collectradius 0
    - foreach <server.online_players> as:player:
        - foreach <[player].inventory.exclude_item[!magnet].list_contents> as:magnet:
            - if <[magnet].any> !=:
                - foreach next
            - if <[magnet].has_flag[magneton]>:
                - foreach <[magnet]> as:value:
                    - define radius <[value].flag[radius]>
                    - if <[radius]> >= <[collectradius]>:
                        - define collectradius <[radius]>
                    - else:
                        - foreach next
            - else:
                - foreach next
            - if <[collectradius]> > 0:
              - repeat 20:
                - run magnet_proc def.location:<[player].location> def.radius:<[collectradius]>
                - wait 1t

magnet_loop_itemframe:
  type: world
  debug: false
  events:
    on delta time secondly every:1:
        - define collectradius 0
        - foreach <server.online_players> as:player:
            - foreach <[player].location.find_entities[item_frame].within[128]> as:magnet:
              - if <[magnet].framed_item.has_flag[magneton]>:
                - foreach <[magnet].framed_item> as:value:
                  - define radius <[value].flag[radius]>
                  - if <[radius]> >= <[collectradius]>:
                      - define collectradius <[radius]>
                      - define target <[magnet]>
                  - else:
                      - foreach next
              - else:
                - foreach next
              - if <[collectradius]> > 0:
                - repeat 20:
                  - run magnet_proc def.location:<[target].location> def.radius:<[collectradius]>
                  - wait 1t
