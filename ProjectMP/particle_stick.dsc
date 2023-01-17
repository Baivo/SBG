# Particle Shape: Circle #
ps_shape_circle:
    type: task
    definitions: location|particle|frequency|rotation
    script:
    - repeat <[frequency]>:
        - wait <element[20].div[<[frequency]>].round_down>t
        # Set particle origion from rotation option
        - choose <[rotation]>:
            - case center:
                - define location <[location].center>
                - define axis y
            - case top:
                - define location <[location].above[0.4]>
                - define axis y
            - case bottom:
                - define location <[location].below[0.4]>
                - define axis y
            - case north:
                - define location <[location].center.with_z[<[location].center.z.sub[0.4]>]>
                - define axis z
            - case east:
                - define location <[location].center.with_x[<[location].center.x.add[0.4]>]>
                - define axis x
            - case south:
                - define location <[location].center.with_z[<[location].center.z.add[0.4]>]>
                - define axis z
            - case west:
                - define location <[location].center.with_x[<[location].center.x.sub[0.4]>]>
                - define axis x
        # Determine x|y|z axis choice based on rotation and play particles accordingly
        - choose <[axis]>:
            - case x:
                - foreach <[location].points_around_x[radius=0.45;points=9]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
                - foreach <[location].points_around_x[radius=0.45;points=7]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
                - foreach <[location].points_around_x[radius=0.45;points=5]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
                - foreach <[location].points_around_x[radius=0.45;points=3]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
            - case y:
                - foreach <[location].points_around_y[radius=0.45;points=9]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
                - foreach <[location].points_around_y[radius=0.35;points=7]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
                - foreach <[location].points_around_y[radius=0.25;points=5]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
                - foreach <[location].points_around_y[radius=0.15;points=3]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
            - case z:
                - foreach <[location].points_around_z[radius=0.45;points=9]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
                - foreach <[location].points_around_z[radius=0.45;points=7]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
                - foreach <[location].points_around_z[radius=0.45;points=5]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
                - foreach <[location].points_around_z[radius=0.45;points=3]> as:loc:
                    - playeffect at:<[loc]> effect:<[particle]> count:1 offset:0.05 speed:0.5
