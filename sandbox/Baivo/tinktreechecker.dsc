# Command to search for tinktree menu items and blocks
Tink_Tree_cjecler_Command:
    type: command
    name: bivttms
    permission: bivttms
    permission message: <&c>No.
    description: Yes
    usage: /bivttms
    script:
    - foreach <server.worlds> as:world:
        - foreach <[world].loaded_chunks> as:chunk:
            - foreach <[chunk].blocks_flagged[tinktreeitem]> as:block:
                - narrate "<&a>Found a tinktree menu item block at <&e><[block].location>"
                - narrate "<&a>Block is <&e><[block].material> placed by <[block].flag[tinktreeitem]>"
                # clickable to teleport to location
                - clickable def.block:<[block]> save:toblock:
                    - teleport <player> <[block]>
                    - narrate "<&a>Teleported to <&e><[block].location>"
                - narrate <element[<&a>Click to teleport to <&e><[block].location>].on_click[<entry[toblock]>]>
    - narrate "<&a>Done searching for tinktree menu items and blocks."

Tink_Tree_Item_Blocker:
    type: world
    debug: false
    events:
        on player clicks item in inventory:
        - announce to_flagged:Baivo "<&a>Inventory is <context.inventory>"
        - announce to_flagged:Baivo "<&b>Clicked inventory is <context.clicked_inventory>"
        - announce to_flagged:Baivo "<&c>Clicked item is <context.item>"
        - announce to_flagged:Baivo "<&d>Click type was <context.click>"