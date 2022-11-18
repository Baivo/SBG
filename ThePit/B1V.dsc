startup:
    type: world
    debug: false
    events:
        after server start:
        - ~discordconnect id:biv token:<secret[biv_token]>

# antidyno:
#     type: world
#     debug: false
#     events:
#         on reload scripts:
#         - ~discordcommand id:biv create group:<discord[biv].group[Stoneburner]> name:fdyno "description:Make the Dynosaurs extinct again" enabled:true save:antidyno

fuckdyno:
    type: world
    debug: false
    events:
        after discord message received:
        - if <context.new_message.author.contains_any_text[155149108183695360]>:
            - foreach <context.new_message.previous_messages[2]> as:message:
                - if <[message].author.contains_any_text[108101240365281280]>:
                    - ~discordmessage id:biv reply:<context.new_message> "https://streamable.com/ukwoko"
                - else:
                    - foreach next

MUTED:
    type: world
    debug: false
    events:
        after discord message received message:*gamer word*:
            - ~discordmessage id:biv reply:<context.new_message> "https://streamable.com/8wv6s1"
            - ~discord id:biv add_role user:<context.new_message.author> role:991342775792570388
        after discord message received message:*gamer word but with a hard r*:
            - ~discordmessage id:biv reply:<context.new_message> "https://streamable.com/8wv6s1"
            - ~discord id:biv add_role user:<context.new_message.author> role:991342775792570388

regular_responses:
    type: world
    debug: false
    events:
        after discord message received message:*femboy*:
            - if <util.random_chance[10]>:
                - random:
                    - ~discordmessage id:biv reply:<context.new_message> "https://streamable.com/dqvr7r"
                    - ~discordmessage id:biv reply:<context.new_message> "https://i.imgur.com/Ua9jz40.gif"
        after discord message received message:can*:
            - if <util.random_chance[5]>:
                - ~discordmessage id:biv reply:<context.new_message> "https://streamable.com/dhe5ud"
        after discord message received message:*B1VNO*:
            - ~discordmessage id:biv reply:<context.new_message> "https://streamable.com/dhe5ud"
# rpsp2:
#     type: world
#     debug: false
#     events:
#         after discord message received:
#         - if <context.new_message.text.contains_text[regex:\booga\sbooga\b]>:
#             - ~discordmessage id:biv channel:<context.new_message.channel> "Unga Bunga"

# rpsp3:
#     type: world
#     debug: false
#     events:
#         after discord message received:
#         - if <context.new_message.text.contains_text[owo]> || <context.new_message.text.contains_text[uwu]>:
#             - ~discordmessage id:biv channel:<context.new_message.channel> "Furry Detected"
