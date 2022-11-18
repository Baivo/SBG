# Author: Baivo
# 
# Random fun or interactable objects in the server spawn

# Gone now, played a sound in Tink's elevator thing
nbf_serverspawn_loudputersound:
    type: task
    definitions: player
    script:
        - ratelimit <player> 10s
        - playsound custom sound:junk_arc at:<[player].location> volume:.1 pitch:1
