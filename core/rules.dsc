rulesPageOne:
    type: command
    name: rules
    description: Learn the rules of the server!
    usage: /rules
    permission: sbg.rules
    script:
    #Initial rule page with clickable buttons
        - clickable rulesPageTwo save:startRulesQuiz
        - narrate "<&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&7><&l>=========<&6><&l>Welcome to Stoneburner Gaming!<&7><&l>=========<&nl><&nl><&e><&o>( Press 't' to open chat )<&r><&a><&nl>You must successfully pass the quiz to play on the server.<&nl>This should only take you a minute or two.<&nl><&nl><&b>Answers to the questions are chosen by clicking them.<&nl>Start by clicking the 'Start Quiz' button below!<&nl><&nl><&r><&7><&l><element[[Start Quiz]].on_click[<entry[startRulesQuiz].command>]>"

wrongAnswer:
    type: task
    script:
    - narrate "<&nl><&4>Wrong answer, try again!<&nl>"

rulesPageTwo:
    type: task
    script:
        - clickable rulesPageThree save:correctPageTwo
        - clickable wrongAnswer save:incorrect
        - narrate "<&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nbsp><&nbsp><&nbsp><&7><&l>=========<&9>Rules Quiz <&8>[<&a>█<&r><&c>----<&8>]<&7><&l>=========<&nl><&nl><&6><&l>Rule 1<&nl><&r><&e>Don’t touch other players things, unless you have their consent. This includes buildings, chests, farms and mobs.<&nl><&nl><&7><&l>Question 1:<&nl><&f>You find a pile of unlocked chests near a farm while exploring. Are you allowed to take what you find inside?<&nl><&nl><&a><element[<&l>[Yes!]<&nl><&a><&o>They aren't locked, so I can take what I find.].on_click[<entry[incorrect].command>]><&nl><&nl><element[<&c><&l>[No!]<&nl><&r><&c><&o>I should find out who owns them and ask first. I should leave them alone until then.].on_click[<entry[correctPageTwo].command>]>"

rulesPageThree:
    type: task
    script:
        - clickable rulesPageFour save:correctPageThree
        - clickable wrongAnswer save:incorrect
        - narrate "<&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nbsp><&nbsp><&nbsp><&7><&l>=========<&9>Rules Quiz <&8>[<&a>██<&r><&c>---<&8>]<&7><&l>=========<&nl><&nl><&6><&l>Rule 2<&nl><&r><&e>PvP is enabled, however, all players must agree to it.<&nl>Attacking players without consent is not allowed.<&nl><&nl><&7><&l>Question 2:<&nl><&f>You see a player you don't recognize stealing from your furnace. Should you pull out a sword and try to kill them?<&nl><&nl><&a><element[<&l>[Yes!]<&nl><&a><&o>They stole my coal, so i'll return the favor by stealing their life!].on_click[<entry[incorrect].command>]><&nl><&nl><element[<&c><&l>[No!]<&nl><&r><&c><&o>I should tell them to leave and call for a staff member to roll back their actions and get my coal back.].on_click[<entry[correctPageThree].command>]>"

rulesPageFour:
    type: task
    script:
        - clickable rulesPageFive save:correctPageFour
        - clickable wrongAnswer save:incorrect
        - narrate "<&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nbsp><&nbsp><&nbsp><&7><&l>=========<&9>Rules Quiz <&8>[<&a>███<&r><&c>--<&8>]<&7><&l>=========<&nl><&nl><&6><&l>Rule 3<&nl><&r><&e>Don’t use client modifications to give an unfair advantage over others and alter their experience.<&nl><&nl><&7><&l>Question 3:<&nl><&f>You notice that as a new player, you can't use the /fly command. Should you just use a modded client to fly around instead?<&nl><&nl><&a><element[<&l>[Yes!]<&nl><&a><&o>I saw another player flying around earlier, so why shouldn't I do it too?].on_click[<entry[incorrect].command>]><&nl><&nl><element[<&c><&l>[No!]<&nl><&r><&c><&o>Using that client puts others at a disadvantage. I should instead raise a petition to let all players have /fly, and incite a minecraft PvP event against the tyranical staff.].on_click[<entry[correctPageFour].command>]>"

rulesPageFive:
    type: task
    script:
        - clickable rulesPageSix save:correctPageFive
        - clickable wrongAnswer save:incorrect
        - narrate "<&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nbsp><&nbsp><&nbsp><&7><&l>=========<&9>Rules Quiz <&8>[<&a>████<&r><&c>-<&8>]<&7><&l>=========<&nl><&nl><&6><&l>Rule 4<&nl><&r><&e>The use of profanities are partially tolerated, so long as it is not directed towards others. Please avoid the use of derogitory or racial slang/terms.<&nl><&nl><&7><&l>Question 4:<&nl><&f>I should call that person the no no word!<&nl><&nl><&a><element[<&l>[Yes!]<&nl><&a><&o>Being a bigot on the internet behind the safety of my minecraft account is a very cool and respected thing to do.].on_click[<entry[incorrect].command>]><&nl><&nl><element[<&c><&l>[No!]<&nl><&r><&c><&o>I'm not a shithead.].on_click[<entry[correctPageFive].command>]>"

rulesPageSix:
    type: task
    script:
        - clickable rulesFinished def.player:<player> save:correctPageSix
        - clickable wrongAnswer save:incorrect
        - narrate "<&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nbsp><&nbsp><&nbsp><&7><&l>=========<&9>Rules Quiz <&8>[<&a>█████<&8>]<&7><&l>=========<&nl><&nl><&6><&l>Rule 5<&nl><&r><&e>Wheaton's Law is the golden rule of our community, and should be considered for every interaction you have with your fellow playrs.<&nl>Wheaton's Law is simple: Don't be a dick!<&nl><&nl><&7><&l>Question 5:<&nl><&f>Do you agree to follow Wheaton's Law, and the other rules we've covered so far?<&nl><&nl><&a><element[<&l>[Yes!]].on_click[<entry[correctPageSix].command>]><&nl><&nl><element[<&c><&l>[No!]].on_click[<entry[incorrect].command>]>"

rulesFinished:
    type: task
    definitions: player
    script:
        - execute as_server "lp user <[player].name> parent add ruleslawyer"
        - wait 2t
        - execute as_player spawn
        - execute as_player "kit starter"
        - narrate "<&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&l>You are free to enjoy the server.<&nl><&nl><&nl><&nl><&nl><&nl><&nl><&nl><&3><&o>Be sure to visit our Bunnings.<&nl><&nl><&nl><&nl><&nl><&nl><&nl><&a><&nl><&nl><&7><&o>Join our discord for a Free Pot & Parma<&nl><&nl><&9><&n>discord.io/stoneburner"
