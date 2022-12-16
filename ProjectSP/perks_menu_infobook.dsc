SPoints_Perks_InfoBook:
    type: item
    material: writable_book
    display name: <&gradient[from=#C7C5FC;to=#C5DFFC]>Perk Info

SPoints_Perks_InfoBook_Script:
    type: task
    definitions: player
    script:
        - define perk <[player].flag[perkmenu.perk]>
        - define perklevel:<[player].flag[<[perk]>].if_null[1]>
        - choose <[perk]>:
            - case perks.smelt.speed:
                - flag <[player]> perkmenu.perkinfo:<script[perks_smelt].data_key[speed.info]>
                - define curr <script[perks_smelt].data_key[speed.<[perklevel]>]>
                - define next <script[perks_smelt].data_key[speed.<[perklevel].add[1]>]>
                - define 10 10
                - define curr <[10].div[<[curr]>].round_to[3]>
                - define curr "<[curr]> seconds"
                - define next <[10].div[<[next]>].round_to[3]>
                - define next "<[next]> seconds"
            - case perks.smelt.efficiency:
                - flag <[player]> perkmenu.perkinfo:<script[perks_smelt].data_key[efficiency.info]>
                - define curr <script[perks_smelt].data_key[efficiency.<[perklevel]>]>
                - define next <script[perks_smelt].data_key[efficiency.<[perklevel].add[1]>]>
                - define 1 1
                - define curr <[1].div[<[curr]>].round_to[3].sub[<[1]>].mul[100]>
                - define curr "+ <[curr]>%"
                - define next <[1].div[<[next]>].round_to[3].sub[<[1]>].mul[100]>
                - define next "+ <[next]>%"
            - case perks.mine.precision:
                - flag <[player]> perkmenu.perkinfo:<script[perks_mine].data_key[precision.info]>
                - define curr <script[perks_mine].data_key[precision.<[perklevel]>]>
                - define next <script[perks_mine].data_key[precision.<[perklevel].add[1]>]>
                - define curr "+ <[curr].mul[100]>%"
                - define next "+ <[next].mul[100]>%"
            - case perks.mine.prospecting:
                - flag <[player]> perkmenu.perkinfo:<script[perks_mine].data_key[prospecting.info]>
                - define curr <script[perks_mine].data_key[prospecting.<[perklevel]>]>
                - define next <script[perks_mine].data_key[prospecting.<[perklevel].add[1]>]>
                - define curr "+ <[curr].mul[100]>%"
                - define next "+ <[next].mul[100]>%"
            - case recerks.farm.greenthumb:
                - flag <[player]> perkmenu.perkinfo:<script[perks_farm].data_key[greenthumb.info]>
                - define curr <script[perks_farm].data_key[greenthumb.<[perklevel]>]>
                - define next <script[perks_farm].data_key[greenthumb.<[perklevel].add[1]>]>
                - define curr "+ <[curr].mul[100]>%"
                - define next "+ <[next].mul[100]>%"
            - case perks.attributes.health:
                - flag <[player]> perkmenu.perkinfo:<script[perks_attributes].data_key[health.info]>
                - define curr <script[perks_attributes].data_key[health.<[perklevel]>]>
                - define next <script[perks_attributes].data_key[health.<[perklevel].add[1]>]>
                - define curr "<[curr].div[2]> hearts"
                - define next "<[next].div[2]> hearts"
            - case perks.mine.reliable:
                - flag <[player]> perkmenu.perkinfo:<script[perks_mine].data_key[prospecting.info]>
                - define curr <script[perks_mine].data_key[prospecting.<[perklevel]>]>
                - define next <script[perks_mine].data_key[prospecting.<[perklevel].add[1]>]>
                - define curr "- <[curr].mul[100]>%"
                - define next "- <[next].mul[100]>%"
            #
        - flag <[player]> perkmenu.perkinfo:->:<&sp><&r>
        - flag <[player]> perkmenu.perkinfo:->:<element[<&7>Current level: <[curr]>]>
        - flag <[player]> perkmenu.perkinfo:->:<element[<&6>Next level: <[next]>]>
