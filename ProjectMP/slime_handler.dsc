slime_spawn_handler:
    type: world
    debug: false
    events:
        on slime spawns:
        - if <util.random_chance[50]>:
            - determine cancelled

slime_split_handler:
    type: world
    debug: false
    events:
        on slime splits:
        - define slime <context.entity>
        - define count <context.count>
        - if <util.random_chance[50]>:
            - define drops <context.count.mul[<util.random.int[1].to[4]>]>
            - drop slime_ball <context.entity.location> quantity:<[drops]>
            - determine cancelled


