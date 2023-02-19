ps_ahh:
    type: task
    definitions: location|particle|points|radius
    script:
    - define points <[points].if_null[10]>
    - define radius <[radius].if_null[1]>
    - define locations <list>
    - define v <[radius].div[<[points]>]>
    - define x <[radius]>
    - define y 0
    - repeat <[points].mul[2]>:
        - define locations:->:<[location].relative[<[x]>,0,<[y]>]>
        - define x <[x].sub[<[v]>]>
        - define y <[y].add[<[v]>]>
    - repeat <[points].mul[2]>:
        - define locations:->:<[location].relative[<[x]>,0,<[y]>]>
        - define x <[x].add[<[v]>]>
        - define y <[y].sub[<[v]>]>


    - foreach <[locations]> as:loc:
        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
