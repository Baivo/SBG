# Created to demonstrate why while true loops are king sh*t
# SWITCH? More like, BI-

resursive:
    type: world
    debug: false
    events:
        after discord message received message:*Recursion*:
            - wait 5s
            - define url https://discord.com/api/webhooks/1032620449055649792/xIEcyApBdQCtsS0p0GY0Dg0IOiMBbg9SXW2mqi8PEpScYVEKkAaHipMzSddeF81izwtL
            - define user "Recursion counter: <server.flag[recursive]>"
            - define pic https://i.imgur.com/MTsV8xK.png
            - define message "Recursion detected."
            - define data '{"content": "<[message]>","username": "<[user]>","avatar_url": "<[pic]>","tts": "false"}'
            - webget <[url]> data:<[data]> headers:<map.with[Content-Type].as[application/json]>
            - flag server recursive:+:1
