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
        - define y <[y].sub[<[v]>]>
        - define x <[x].add[<[v]>]>
    - repeat <[points]>:
        - define locations:->:<[location].relative[<[x]>,0,<[y]>]>
        - define y <[y].sub[<[v]>]>
        - define x <[x].sub[<[v]>]>
    - repeat <[points]>:
        - define locations:->:<[location].relative[<[x]>,0,<[y]>]>
        - define y <[y].add[<[v]>]>
        - define x <[x].sub[<[v]>]>
    - repeat <[points]>:
        - define locations:->:<[location].relative[<[x]>,0,<[y]>]>
        - define y <[y].add[<[v]>]>
        - define x <[x].add[<[v]>]>
    - foreach <[locations]> as:loc:
        - playeffect at:<[loc]> effect:<[particle]> offset:0.0
