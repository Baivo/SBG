# Author: Baivo
# Very simple example functions that apply a specified effect to a player when entering or moving inside the trigger running the function. 
# 
# I plan to come back to this once I have netblocks setup to allow configuring and passing through function defs.
# Would allow defining duration and amplification without hardcoding.
# Example of how this would work in the first function.

## Example of planned definable effect application
nbf_effect_nbdata:
  type: task
  definitions: player|effect|power|duration
  script:
    - cast <[effect].if_null[SPEED]> duration:<[duration].if_null[3s]> amplifier:<[power].if_null[0]> <[player]>

## Examples of static effect application.
# Still useful if you have a use case in mind and would like to have a static effect available for using across many areas/netblocks.
nbf_effect_speed:
  type: task
  definitions: player
  script:
    - cast speed duration:10t amplifier:1 <[player]>

nbf_effect_levitation:
  type: task
  definitions: player
  script:
    - cast levitation duration:10t amplifier:2 <[player]>

nbf_effect_slow:
  type: task
  definitions: player
  script:
    - cast slow duration:10t  amplifier:1 <[player]>

nbf_effect_blindness:
  type: task
  definitions: player
  script:
    - cast blindness duration:5s amplifier:0 <[player]>
    # Small time frames will result in the blindness effect not occuring, or blinking effect.
    # If you want actual blindness, use a higher duration. If you want actual blindness, but have it turn off as soon as a player exits a trigger location,
    # consider creating a separate function to clear the effect, and hook it up to trigger blocks on the boundary of your blindness trigger area. 
    # Or use flags or any other method, whatever blows your hair back.
