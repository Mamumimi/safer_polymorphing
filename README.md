# Safer Polymorphing

Improves the polymorph experience by making it so your allies and homing projectiles won't betray you, probably.

Not currently working as intended, because I tried using ModTextFileSetContent() outside of init. Instead I will need to duplicate every faction via OnModPostInit() into poly_$faction and hot-swap the poly'd player between them. An extra faction will have to be made for if the player has the Plague Rats perk so their rats won't attack when polymorphed.
Also, there's a problem with the homing_target removal in that projectiles will still home in on you for 1 frame, which is extremely bad for Projectile Area Teleport or stacks of other homing spells. Not sure if this can be mitigated.
Lastly, pheromone will function like berserkium if you're polymorphed due to setting your faction back to the player faction. Not sure if this can be mitigated either, but this one's a relatively minor issue.

This was supposed to work by making a new faction and filling its relations stats with the best of Player and the polymorph target dynamically. This meant you wouldn't lose the friendliness from your allies, rats (plage rats perk), or your polymorph target faction. It doesn't mean those things can't hurt you.

Untested in multiplayer.

## Installation instructions

 - Don't, unless you're helping achieve the desired functionality. It's not working right yet and just makes you friendly with everyone when you get poly'd.

## To-Do

- Move faction editing code out of charmer.lua into init.lua (it don't work outside of init) and merge it with a new non-stolen faction generator to create duplicated poly_$factions with the highest relations of player and input faction
- Put function split_string in its own file and dofile_once it
- Figure out how tf to configure vscode's Format Document (Ctrl+Shift+I) button to be consistent, maybe set it up to auto-format on saving
- Define things outside of OnPlayerSpawned and OnModPostInit, then call them from inside.
- Try removing the EntityKill from charmer.lua and spamming the applier entity from frame 0 to 2 (add OnAdded component basically, lifetime is already at 2). Also test if it really needs 2 frames of lifetime or just 1.
- Try creating a copy of all valid poly targets xml without the homing/enemy tag: PolymorphTableAddEntity(), PolymorphTableGet(), PolymorphTableRemoveEntity(), PolymorphTableSet(), etc, which has no enemy or homing_target tags.
- Finding a solution to retain safeness of projectiles vs poly_$faction would be epic but likely infeasible without modifying every cast state a-la datat to ignore poly_$faction-aligned entities.
- Modify Pheromone or charm effect xmls to not apply charm if it's polymorphed_player who is affectd since the effect will be similar to berserkium and that's weird. Hearts means more love, not less!
- If a 0-frame tag editing solution is infeasible, consider modifying poly effects (and adding compat for modded poly effects) to give 1-2 frames of protection from all until homing_target can be removed. This necessitates use of dont_collide_with_tag
- Put a little work into verifying if it works in Entangled Worlds; OnPlayerSpawned might conflict with the current faction-editing method for MP.