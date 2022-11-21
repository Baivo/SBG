# Author: Baivo
# Was used for testing a stat upgrade system
health_gem:
    type: item
    material: magenta_dye
    mechanisms:
        hides:
            - ENCHANTS
            - ITEM_DATA
    display name: <&4><&l>Health Gem
    lore:
    - <&c>Consume to add half a heart to your maximum HP
    enchantments:
    - fortune:1
    allow in material recipes: false
    flags:
        gems: health
    recipes:
        1:
            type: shaped
            output_quantity: 1
            input:
            - diamond|diamond|diamond
            - diamond|redstone_block|diamond
            - diamond|diamond|diamond

consume_health_gem:
    type: world
    events:
        on player right clicks air with:health_gem:
            - take iteminhand
            - flag player healthLevel:++
            - run player_health_attribute

player_health_attribute:
    type: task
    script:
        - define healthLevel <player.flag[healthLevel].add[20]>
        - narrate "<&c>Your maximum HP is now <&4><[healthLevel]>"
        - adjust <player> max_health:<[healthLevel]>
        - sidebar set title:<&a><&l>Stats "values:<&8><&l>-=-=-=-=-=-=-=-=-|<&7><&l>Health Level: <&6><&l><player.flag[healthLevel]>|<&7><&l>Max Health: <&c><&l><[healthLevel]>|<&8><&l>-=-=-=-=-=-=-=-=-" players:<player>
        - wait 10s
        - sidebar remove players:<player>

##########################

dexterity_gem:
    type: item
    material: yellow_dye
    mechanisms:
        hides:
            - ENCHANTS
            - ITEM_DATA
    display name: "<&6><&l>Dexterity Gem"
    lore:
    - "<&e>Consume to increase your Dexterity"
    - "<&e>Increases attack speed"
    enchantments:
    - fortune:1
    allow in material recipes: false
    flags:
        gems: dexterity
    recipes:
        1:
            type: shaped
            output_quantity: 1
            input:
            - rabbit_foot|rabbit_foot|rabbit_foot
            - rabbit_foot|gold_block|rabbit_foot
            - rabbit_foot|rabbit_foot|rabbit_foot

consume_dexterity_gem:
    type: world
    events:
        on player right clicks air with:dexterity_gem:
            - take iteminhand
            - flag player dexterityLevel:++
            - run player_dexterity_attribute

player_dexterity_attribute:
    type: task
    script:
        - define dexterityLevel <player.flag[dexterityLevel].add[4]>
        - adjust <player> attribute_base_values:[generic_attack_speed=<[dexterityLevel]>]
        - narrate "Your Dexterity is now <[dexterityLevel]>"
        - sidebar set title:<&a><&l>Stats "values:<&8><&l>-=-=-=-=-=-=-=-=-|<&7><&l>Dexterity Level: <&6><&l><[dexterityLevel]>|<&8><&l>-=-=-=-=-=-=-=-=-" players:<player>
        - wait 10s
        - sidebar remove players:<player>

############################
