# Author: Baivo
# Version 0.0
# 
nbf_trise_ghostbridge:
    type: task
    definitions: player|trigger
    script:
    - ratelimit <[player]> 1t
    - ~run ps_shape_circle def.location:<[trigger].center> def.particle:sneeze def.frequency:1 def.rotation:center
