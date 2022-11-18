# Author: Baivo
# Deserves it's own item
debug_hoe:
    type: world
    events:
        on player right clicks block with:golden_hoe:
        - if <player.is_op>:
            - narrate <player.cursor_on.material>
            - narrate <player.cursor_on.material.name>
            - determine cancelled
        on player right clicks entity with:golden_hoe:
        - if <player.is_op>:
            - narrate <player.target.describe>
            - determine cancelled
