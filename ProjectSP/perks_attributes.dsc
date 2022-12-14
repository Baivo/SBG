perks_attributes:
    type: data
    health:
        1: 20
        2: 22
        3: 24
        4: 26
        5: 28
        6: 30
        7: 32
        8: 34
        9: 36
        10: 40
        11: 42
        12: 44
        13: 46
        14: 48
        15: 50
        16: 52
        17: 54
        18: 56
        19: 58
        20: 60
        21: 60
        info:
            - Increase your max health.
            - Upgrades by whole hearts.
            - Make a scarecrow envious

perks_attributes_tasks:
    type: task
    definitions: player|perk
    script:
        - choose <[perk]>:
            - case perks.attributes.health:
                - adjust <[player]> max_health:<script[perks_attributes].data_key[health.<[player].flag[perks.attributes.health]>]>
                - heal 100 <[player]>

## perk menu item logic
# Health
Spoints_Perks_Menu_Item_AttributesHealth:
    type: item
    material: apple
    display name: <&gradient[from=#FBB800;to=#FDD800]>Maximum Health
    lore:
    - <&gradient[from=#C7C5FC;to=#C5DFFC]>Click to open Level-Up menu
    flags:
        script: SPoints_Perks_Menu_AttributesHealth_Script
        cost: 100

SPoints_Perks_Menu_AttributesHealth_Script:
    type: task
    definitions: player
    script:
        - run Spoints_Perks_levelup_script def.cost:100 def.perk:perks.attributes.health def.player:<[player]> def.perkname:Maximum<&sp>Health
