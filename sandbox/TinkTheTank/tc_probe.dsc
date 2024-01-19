tc_probe:
	type: item
    material: echo_shard
    display name: <&b><&l>TinkCorp Rectal Probe
    lore:
    - <&f><&o>Right click a player to probe them.

tc_probe_events:
	type: world
    events:
    	on player right clicks player with:t_probe:
        # - ratelimit <player> 1t
        - shoot particle[particle_type=snowflake] origin <player> speed:0.1
        - playsound <player> sound:item_glow_ink_sac_use pitch:1.0 volume:1.0
       