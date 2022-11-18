# Author: Baivo
# Version 1.0
# 
# Requires the block attractors script located /ext/... <-- update once available
#
# Items created to be safe for distribution to players
# Uses the block attractors libary by old mate, i'll put his name in here once I upload the damn thing

Whipper_snipper:
    type: item
    material: shears
    display name: <&e>DeWALT 18V 3Ah Cordless Line Trimmer
    mechanisms:
        unbreakable: true
        hides: all
        custom_model_data: 171
    enchantments:
        - unbreaking:1
    flags:
        attractor:
            match: vanilla_tagged:replaceable_plants
            radius: 4
