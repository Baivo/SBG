ps_ahh:
    type: task
    definitions: location|particle|points|radius
    script:
    - define points <[points].if_null[10]>
    - define radius <[radius].if_null[1]>
    - define locations <list>
    - define v <[radius].div[<[points]>]>
    - define y <[radius]>
    - define x 0
    - repeat <[points]>:
        - define locations:->:<[location].relative[<[x]>,0,<[y]>]>
        - define y <[y].sub[<[y]>]>
        - define x <[y].add[<[x]>]>
    - repeat <[points]>:
        - define locations:->:<[location].relative[<[x]>,0,<[y]>]>
        - define y <[y].sub[<[y]>]>
        - define x <[x].sub[<[x]>]>
    - repeat <[points]>:
        - define locations:->:<[location].relative[<[x]>,0,<[y]>]>
        - define y <[y].add[<[y]>]>
        - define x <[x].sub[<[x]>]>
    - repeat <[points]>:
        - define locations:->:<[location].relative[<[x]>,0,<[y]>]>
        - define y <[y].add[<[y]>]>
        - define x <[x].add[<[x]>]>
    - foreach <[locations]> as:loc:
        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
