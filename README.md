# Safer Polymorphing

Improves the polymorph experience by making it so your allies and homing projectiles won't betray you, probably.

Not currently working as intended, because I tried using ModTextFileSetContent() outside of init. Instead I will need to duplicate every faction via OnModPostInit() into poly_$faction and hot-swap the poly'd player between them. An extra faction will likely have to be made for plague rats and any modded functions that increase player-faction relations. There's a problem with the homing_target removal in that projectiles will still home in on you for 1 frame, which is extremely bad for Projectile Area Teleport or stacks of other homing spells. Finally, pheromone will function like berserkium if you're polymorphed due to setting your faction back to the player faction.

This was supposed to work by making a new faction and filling its relations stats with the best of Player and the polymorph target dynamically. This meant you wouldn't lose the friendliness from your allies, rats (plage rats perk), or your polymorph target faction. It doesn't mean those things can't hurt you.

Untested in multiplayer but it'll probably work fine.

## Installation instructions

 - Don't use this yet. As-is it's a cheat that makes enemies not attack you when you're polymorphed.
