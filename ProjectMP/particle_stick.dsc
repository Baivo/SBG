particle_stick:
    type: item
    material: stick
    mechanisms:
        custom_model_data: 17
    display name: <&d>Particle Stick
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
        - define id <util.random_uuid>
        - flag server particle_stick_location:->:<[location]>
        - flag server particle_stick_location.<[location]>:->:<[id]>
        - flag server particle_stick_location.<[location]>.<[id]>.owner:->:<player.name>
        - flag server particle_stick_location.<[location]>.<[id]>.particle:->:<player.item_in_hand.flag[particle]>
        - flag server particle_stick_location.<[location]>.<[id]>.count:->:<player.item_in_hand.flag[particle_count]>
        - flag server particle_stick_location.<[location]>.<[id]>.animation:->:<player.item_in_hand.flag[particle_animation]>
        on player left clicks bllck with:particle_stick:
        - determine cancelled passively
        - define location <context.relative>
        - flag server particle_stick_location:<[location]>:!
        on player drops particle_stick:
        - determine cancelled passively
        - narrate menu opens

sparkle:
    type: world
    debug: true
    events:
        on delta time secondly:
        - foreach <server.flag[particle_stick_location]> as:location:
            - foreach <server.flag[particle_stick_location.<[location]>]> as:particle:
                - if <server.flag[particle_stick_location.<[location]>.<[particle]>.animation]> == sparkle:
                    - playeffect at:<[location]> effect:<server.flag[particle_stick_location.<[location]>.<[particle]>.particle]> quantity:<server.flag[particle_stick_location.<[location]>.<[particle]>.count]> offset:0.5,0.5,0.5 speed:0.5 data:0
                - else:
                    - foreach next
