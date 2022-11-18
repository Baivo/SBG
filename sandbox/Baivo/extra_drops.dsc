# Author: Baivo
# Concept for additional drops. Barely thrown together in 5 minutes to explain an idea. 
# Probably going to flesh out the idea with adjustable drop-rate and include it in ProjectPP or for use with ProjectEV

gem_drop:
    type: world
    events:
        after player breaks stone:
            - if <util.random_chance[1]>:
                - random:
                    - drop diamond <context.location> quantity:1
                    - drop raw_iron <context.location> quantity:1
                    - drop raw_gold <context.location> quantity:1
                    - drop raw_copper <context.location> quantity:1
                    - drop emerald <context.location> quantity:1
                    - drop redstone <context.location> quantity:1
                    - drop lapis_lazuli <context.location> quantity:1
                    - drop coal <context.location> quantity:1
                    - drop amethyst_shard <context.location> quantity:1
#
