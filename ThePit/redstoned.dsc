redstoned:
    type: world
    debug: false
    events:
        on player right clicks block type:redstone_wire with:paper:
            - ratelimit <player> 1t
            - playsound <player.location> sound:entity_fox_sniff pitch:0.2 volume:12
            - cast speed amplifier:1 duration:30
            - modifyblock <context.location> air
            - determine cancelled passively
