# Project Netblock
### Come back later for better info, I'll be putting a lot more effort into these docs as I progress with adding features and functions

***Hello*, virile gamers.** 

I am releasing the first version of my netblocks system for the gilded yet greasy hands of my fellow degenizens.

*"What are netblocks?"*
They are map triggers, but cooler. Command blocks, but cooler. It comes in two parts. 

### The Netblock
Think of this like a router, or a switchboard, or a controller. Each netblock can have one function, and that function can be changed or cleared on demand. 

### The Connection(s)
A connection is an invisible block trigger that is attached to a netblock. When a player enters a connection, they trigger the function of the netblock they are connected to. 

Interacting and configuring netblocks is done using the configurator. 
Netblocks are crafted by placing a barrier and an observer in any crafting grid. 
The configurator is crafted by placing a barrier and an arrow in any crafting grid. 

---
*"What functions are available?"*

I will be working on making an example library of functions that might be handy, as well as obviously having every solution I use available to use and modify. 

The intention of this system, however, is to allow anyone to write their own functions and run them through netblocks. 
A "netblock" function is quite literally just a regular denizen task. When you set a netblock function, you're just telling it to run a task with that name. 
Denizen documentation is thorough, and I'm on hand and encourage any questions thrown my way. https://meta.denizenscript.com/Docs/Search/task#task%20script%20containers

 For now, netblock connections pass the following defs to all functions:
       trigger: the LocationTag of the connection that was triggered
       player: the PlayerTag of the player that triggered the connection
       netblock: the LocationTag of the netblock that the connection is connected to
       function: the script name of the function that is being run
---
*"Ok, lmao, but why?"*
There are ways of achieving what I've created here, both with vanilla command blocks, plugins, or even denizen area flagging, etc.

These are all used in different scenarios, and all require an unreasonable amount of required reading for a person trying to learn them. I don't blame anyone for cracking the shits and giving up on it. Even when they are working correctly, they're a pain in the ass to plan and maintain. 

These netblocks will allow the kind of cool interactions between the world and the player that any sensible game engine supports by default, without having to teach you all half a dozen systems to get stuff working. Even if nobody else contributes to the list of available functions, I'll be creating enough of my own that you should either have the one you need or only need to tweak a solution slightly for your own use. 
---

##### My netblock function script naming conventions: 
*ScriptType_FunctionGroup_Function*<br>
nbf_*: Netblock function<br>
nbfe_*: Netblock function event for a netblock function<br>
nbfd_*: Netblock function data for a netblock function<br>
nbfp_*: Netblock function procedure for a netblock function<br>
nbf_note_*: Netblock function belonging to the 'note' category<br>

##### Examples from music_notes script:
*nbf_note_Instrument_Note*<br>
nbf_note_Pling_13G: Play note G4 using the pling instrument.<br>
