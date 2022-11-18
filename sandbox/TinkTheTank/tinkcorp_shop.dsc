# Author: Baivo
# Makes the NPC's in TinkCorp Shop (or any npc flagged with tinkcorp_shop) open the specified inventory/shop (currently server points shop)
tinkcorp_shop:
    type: world
    debug: true
    events:
        on player right clicks npc:
        - if !<context.entity.has_flag[tinkcorp_shop]>:
            - stop
        - run spoints_shop_update def.inv:<inventory[Spoints_Shop_<player.name>]> def.player:<player>
        - inventory open d:<inventory[Spoints_Shop_<player.name>]>
