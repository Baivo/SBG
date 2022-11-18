sp_map_command:
    type: command
    name: map
    description: Current link to the world maps
    usage: /map
    script:
    - narrate <&n><element[Explore our 3D map here!].custom_color[emphasis].on_hover[Opens in your browser.].click_url[http://smp.stoneburnergaming.com:8124/]>
    - narrate <&n><element[Explore our 2D map here!].custom_color[emphasis].on_hover[Opens in your browser.].click_url[http://smp.stoneburnergaming.com:8123/]>
    - narrate "<&e>You may receive an SSL error as the sites are currently running as HTTP only"
