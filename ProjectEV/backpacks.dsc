Backpack_Events:
    type: world
    debug: true
    events:
        on player crafts backpack_item:
        - define ID <player.name><util.random_uuid>
        - flag server Backpack.<[ID]>:<player>
        - flag server Inventory.<[ID]>:<inventory[Backpack_Inventory]>
        - note <inventory[<server.flag[Inventory.<[ID]>]>]> as:Backpack_Inventory_<[ID]>
        - determine <context.item.with_flag[UID:<[ID]>].with_flag[backpack]>
        on player right clicks block type:air using:hand with:backpack_item:
        - ratelimit <player> 1t
        - define ID <player.item_in_hand.flag[UID]>
        - inventory open d:Backpack_Inventory_<[ID]>
        on player right clicks block location_flagged:backpack:
        - if <player.has_flag[placedbackpack]>:
            - stop
        - else:
            - ratelimit <player> 1t
            - define ID <context.location.flag[UID]>
            - inventory open d:Backpack_Inventory_<[ID]>
        on player breaks block location_flagged:backpack:
        - define loc <context.location>
        - define BP <context.location.flag[backpack]>
        - flag <[loc]> backpack:!
        - flag <[loc]> UID:!
        - determine <[BP]>
        on player swaps items offhand:backpack_item:
        - playsound <player.location> sound:item_armor_equip_gold level:1.0 pitch:1.0
        on player swaps items main:backpack_item:
        - playsound <player.location> sound:item_armor_equip_gold level:1.0 pitch:0.8
        on player clicks in backpack_inventory:
        - if <context.cursor_item.has_flag[backpack]>:
            - determine cancelled
        - if <context.item.has_flag[backpack]>:
            - determine cancelled
        on player drags backpack_item in backpack_inventory:
        - determine cancelled
        on player left clicks block using:hand with:backpack_item:
        - ratelimit <player> 1t
        - inventory open d:Backpack_GUI
        on player clicks backpack_recolour in backpack_gui:
        - ratelimit <player> 1t
        - inventory open d:Backpack_GUI_Colours
        on player clicks leather in backpack_gui_colours:
        - inventory adjust d:<player.inventory> slot:hand custom_model_data:<context.item.custom_model_data>
        - playsound <player.location> sound:item_bucket_empty level:1.0 pitch:1.0
        - inventory close

## ITEMS ##
Backpack_Inventory:
    type: inventory
    inventory: chest
    title: <&6>Backpack - Inventory
    size: 54

Backpack_GUI:
    type: inventory
    inventory: dispenser
    gui: true
    title: <&6>Backpack - Settings
    size: 9
    slots:
    - [Backpack_Recolour] [] []
    - [] [] []
    - [] [] []

Backpack_GUI_Colours:
    type: inventory
    inventory: chest
    gui: true
    title: <&6>Backpack - Colours
    size: 18
    slots:
    - [<item[leather[display=<&a>Click to change colour!;custom_model_data=170]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=171]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=172]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=173]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=174]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=175]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=176]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=177]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=178]]>]
    - [<item[air]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=179]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=1710]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=1711]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=1712]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=1713]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=1714]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=1715]]>] [<item[leather[display=<&a>Click to change colour!;custom_model_data=1716]]>]

Backpack_Recolour:
    type: item
    material: bucket
    display name: <&a>Change Backpack Colour

Backpack_GUI_Colours_Item:
    type: item
    material: leather
    display name: <&a>Click to change colour

Backpack_Item:
    type: item
    material: leather
    display name: <&6>Backpack
    lore:
    - <&sp>
    - <&e>Right click to open
    - <&e>Left click to edit
    - <&sp>
    - <&3><&o>Wear it in your off-hand!
    mechanisms:
        custom_model_data: 170
    recipes:
        1:
            type: shaped
            input:
            - air|leather|air
            - leather|iron_ingot|leather
            - air|leather|air

## disabled events ##
# Place backpack #
        # on player right clicks block type:!air using:hand with:backpack_item:
        # - ratelimit <player> 1t
        # - define loc <context.relative>
        # - define bp <item[player_head[skull_skin=eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZWZiNmEzZDdkYmE5N2JiNmU3Zjc5YTE1NjI3YWVjNjM2OTc5MTIzM2Y4MzNmYTc0OWVmMjFiZWQ3OWU1OWU5OCJ9fX0q]]>
        # - define ID <player.item_in_hand.flag[UID]>
        # - modifyblock <[loc]> player_head
        # - adjust <[loc]> skull_skin:<[bp].skull_skin>
        # - flag <[loc]> backpack:<player.item_in_hand>
        # - flag <[loc]> UID:<[ID]>
        # - take item:<player.item_in_hand>
        # - flag player placedbackpack expire:1s
##

