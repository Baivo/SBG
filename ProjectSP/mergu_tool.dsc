
# Utility to create static menus in-game for use in GUIs
# Created by Mergu#0001
# My hero and savior

# Usage:
# /menu create (menu id)
# /menu edit (menu id)
# /menu title (menu id)
# /menu delete (menu id)

# demo_menu:
#   type: inventory
#   debug: false
#   inventory: chest
#   gui: true
#   size: 18
#   data:
#     menu: example_menu

# 1.1 Updated for ProjectSP compatibility

# 1.2 Updated logic flow for the on player opens inventory event to allow less static menu operatoin for ProjectSP

menu_creator_events:
  type: world
  debug: false
  events:
    on player clicks menu_* in menu_creator_invtype:
      - flag <player> new_menu.type:<context.item.script.name>
      - inventory close
      - narrate "Please type a title for this menu in the chat. Denizen tags are supported."
      - flag <player> get_menu_title
    on player chats priority:-100 bukkit_priority:lowest:
      - if <player.has_flag[get_menu_title]>:
        - determine passively cancelled
        - flag <player> get_menu_title:!
        - narrate <context.message.parsed>
        - flag <player> new_menu.title:<context.message.parsed>
        - define inv <inventory[menu_template_<player.flag[new_menu.type].after[_]>]>
        - adjust <[inv]> title:<player.flag[new_menu.title]>
        - inventory open d:<[inv]>
      - else if <player.has_flag[edit_menu_title]>:
        - determine passively cancelled
        - flag server custom_menus.<player.flag[edit_menu_title]>.title:<context.message.parsed>
        - flag <player> edit_menu_title:!
        - narrate "Updated menu title."
    on player closes menu_template_*:
      - flag server custom_menus.<player.flag[new_menu.name]>.title:<player.flag[new_menu.title]>
      - flag server custom_menus.<player.flag[new_menu.name]>.type:<player.flag[new_menu.type]>
      - flag server custom_menus.<player.flag[new_menu.name]>.slots:<context.inventory.map_slots>
      - narrate "Menu saved."
    on player opens inventory:
      - if !<context.inventory.script.exists> or !<context.inventory.script.parsed_key[data.menu].exists>:
        - stop
      - define menu_name <context.inventory.script.parsed_key[data.menu]>
      - if !<server.has_flag[custom_menus.<[menu_name]>]>:
        - announce to_console "Tried to open a menu that does not exist, <[menu_name]> for script <context.inventory.script.name>."
        - stop
      - ratelimit <player> 2t
      - determine passively cancelled
      - define inv <context.inventory>
      - inventory set d:<[inv]> o:<server.flag[custom_menus.<[menu_name]>.slots]>
      - wait 1t
      - if <context.inventory.script.name> == spoints_shop:
        - adjust <[inv]> "title:<&gradient[from=#C7C5FC;to=#C5DFFC]>Point Shop <&7><&l>| <&a>SP Balance: <&3><player.flag[SP_balance]>"
      - if <context.inventory.script.name> == spoints_perks_menu:
        - adjust <[inv]> "title:<&gradient[from=#C7C5FC;to=#C5DFFC]>Perk Menu <&7><&l>| <&a>SP Balance: <&3><player.flag[SP_balance]>"
        - foreach <[inv].map_slots> key:slot as:item:
          - define lore <[item].lore>
          - define lore:->:<&7>Cost<&co><&sp><&a><[item].script.parsed_key[data.cost].if_null[999]>
          - inventory adjust d:<[inv]> slot:<[slot]> lore:<[lore]>
      - if <context.inventory.script.name> == spoints_perks_levelup:
        - define player <player>
        - define perk <player.flag[perkmenu.perk]>
        - define perkname <player.flag[perkmenu.perkname]>
        - adjust <[inv]> title:<&gradient[from=#C7C5FC;to=#C5DFFC]><[perkname]><&sp><&7><&l><&gt><&gt><&sp><&e>Lvl<&sp><&6><[player].flag[<[perk]>].if_null[1]>
        - inventory adjust d:<[inv]> slot:3 display:<element[<&7>Cost<&co><&7><&sp><&a><[player].flag[perkmenu.cost]>]>
        - inventory adjust d:<[inv]> slot:5 display:<element[<&a>SP<&sp>Balance:<&sp><&3><player.flag[SP_balance]>]>
        - run SPoints_Perks_InfoBook_Script def.player:<[player]>
        - inventory adjust d:<[inv]> slot:1 lore:<[player].flag[perkmenu.perkinfo]>
      - inventory open d:<[inv]>

menu_creator:
  type: command
  debug: false
  name: menu
  description: Utility to create static menus in-game for use in GUIs
  usage: /menu (create/edit/title/delete) (menu id)
  permission: your.permission.here
  tab completions:
    1: create|edit|title|delete|help
    2: <server.flag[custom_menus].keys||<list>>
  script:
    - define menu_name <context.args.get[2]||none>
    - choose <context.args.first||none>:
      - case create:
        - if <[menu_name]> == none:
          - narrate "Must provide a menu name."
          - stop
        - if <server.has_flag[custom_menus.<[menu_name]>]>:
          - narrate "This menu already exists"
          - stop
        - flag <player> new_menu:!
        - flag <player> new_menu.name:<[menu_name]>
        - inventory open d:menu_creator_invtype
      - case edit:
        - if <[menu_name]> == none:
          - narrate "Must provide a menu name."
          - stop
        - if !<server.has_flag[custom_menus.<[menu_name]>]>:
          - narrate "This menu does not exist"
          - stop
        - flag <player> new_menu:!
        - flag <player> new_menu.name:<[menu_name]>
        - flag <player> new_menu.title:<server.flag[custom_menus.<[menu_name]>.title]>
        - flag <player> new_menu.type:<server.flag[custom_menus.<[menu_name]>.type]>
        - define inv <inventory[menu_template_<player.flag[new_menu.type].after[_]>]>
        - adjust <[inv]> title:<player.flag[new_menu.title]>
        - inventory set d:<[inv]> o:<server.flag[custom_menus.<[menu_name]>.slots]>
        - inventory open d:<[inv]>
      - case title:
        - if <[menu_name]> == none:
          - narrate "Must provide a menu name."
          - stop
        - if !<server.has_flag[custom_menus.<[menu_name]>]>:
          - narrate "This menu does not exist"
          - stop
        - flag <player> edit_menu_title:<[menu_name]>
        - narrate "Please type a new menu title in the chat. Denizen tags are supported."
      - case delete:
        - if <[menu_name]> == none:
          - narrate "Must provide a menu name."
          - stop
        - if !<server.has_flag[custom_menus.<[menu_name]>]>:
          - narrate "This menu does not exist"
          - stop
        - flag server custom_menus.<[menu_name]>:!
        - narrate "Menu removed"
      - default:
        - narrate "Usage: /menu [create/edit/title/delete] [menu id]"

menu_creator_invtype:
  type: inventory
  debug: false
  inventory: chest
  size: 9
  gui: true
  title: Choose your menu size
  slots:
    - [] [menu_9] [menu_18] [menu_27] [menu_36] [menu_45] [menu_54] [menu_hopper] []

menu_9:
  type: item
  debug: false
  material: chest
  lore:
  - 9 slots

menu_18:
  type: item
  debug: false
  material: chest
  lore:
  - 18 slots

menu_27:
  type: item
  debug: false
  material: chest
  lore:
  - 27 slots

menu_36:
  type: item
  debug: false
  material: chest
  lore:
  - 36 slots

menu_45:
  type: item
  debug: false
  material: chest
  lore:
  - 45 slots

menu_54:
  type: item
  debug: false
  material: chest
  lore:
  - 54 slots

menu_hopper:
  type: item
  debug: false
  material: hopper
  lore:
  - 5 slots

menu_template_9:
  type: inventory
  inventory: chest
  debug: false
  size: 9

menu_template_18:
  type: inventory
  inventory: chest
  debug: false
  size: 18

menu_template_27:
  type: inventory
  inventory: chest
  debug: false
  size: 27

menu_template_36:
  type: inventory
  inventory: chest
  debug: false
  size: 36

menu_template_45:
  type: inventory
  inventory: chest
  debug: false
  size: 45

menu_template_54:
  type: inventory
  inventory: chest
  debug: false
  size: 54

menu_template_hopper:
  type: inventory
  inventory: hopper
  debug: false
