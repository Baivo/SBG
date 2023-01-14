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
        particle: magic
        particle_count: 10
        particle_animation: sparkle

particle_stick_events:
    type: world
    events:
        on player right clicks block with:particle_stick:
        - define location <context.relative>
        - narrate <[location]>
