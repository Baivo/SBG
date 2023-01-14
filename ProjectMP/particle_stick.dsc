particle_stick:
    type: item
    material: stick
    mechanisms:
        custom_model_data: 17
    display name: &dParticle Stick
    lore:
    - Right click to place particles
    - Left click to remove particles
    - Throw (Q) to change particle type
    flags:
        particle: SPELL_WITCH
        particle_count: 10
        particle_animation: sparkle

particle_stick_events:
    type: world
    events:
        on player right clicks block with:particle_stick:
        - determine cancelled passively
        - define location <context.relative>
        - flag server particle_stick_location:->:<[location]>
        - flag server particle_stick_location.<[location]>.owner:->:<player.name>
        - flag server particle_stick_location.<[location]>.particle:->:<player.item_in_hand.flag[particle]>
        - flag server particle_stick_location.<[location]>.count:->:<player.item_in_hand.flag[particle_count]>
        - flag server particle_stick_location.<[location]>.animation:->:<player.item_in_hand.flag[particle_animation]>
        on player left clicks bllck with:particle_stick:
        - determine cancelled passively
        - define location <context.relative>
        - flag server particle_stick_location:<[location]>:!
        on player drops particle_stick:
        - determine cancelled passively
        - narrate menu opens

sparkle:
    type: world
    events:
        on delta time secondly:
        - foreach <server.flag[particle_stick_location]> as:location:
            - if <[location].flag[animation]> == !sparkle:
                - foreach next
            - playeffect at:<[location]> effect:<[location].flag[particle]> quantity:<[location].flag[count]> offset:0.5,0.5,0.5 speed:0.5 data:0
