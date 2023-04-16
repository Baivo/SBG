# Author: Baivo
# Was initially a demo script to show Rob something, but could be repurposed to allow dispensing blocks as blocks, not just items. 
# Think: Lava bucket in dispenser dispenses actual lava, not a bucket. Why not allow the same for blocks, say, a dispenser based cobweb trap? 


adv_dispenser:
    type: world
    debug: false
    events:
        after dispenser dispenses item:
            - define front    <context.location.with_facing_direction.forward>
            - define item     <context.item>
            - define mat      <[item].material>
            - define entity   <[front].center.find_entities[dropped_item].within[1].filter[item.material.equals[<[mat]>]].first.if_null[]>
            - define quantity <[entity].item.quantity.sub[1].if_null[0]>
            - stop if:<[mat].is_block.not>
            - stop if:<[front].material.is_solid>
            # - if <context.item.material> != <material[birch_sapling]>:
            #     - determine passively
            - else:
                - if <[quantity]> == 0:
                    - remove <[entity]>
                - else:
                    - adjust <[entity]> item:<[entity].item.with[quantity=<[entity].item.quantity.sub[1]>]>
                - modifyblock <[front]> <[mat]>
