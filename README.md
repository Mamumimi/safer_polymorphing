# Safer Polymorphing

Improves the polymorph experience by making it so your allies and homing projectiles won't betray you, probably.

Not currently working as intended, because I tried using ModTextFileSetContent() outside of init. Instead I will need to duplicate every faction via OnModPostInit() into poly_$faction and hot-swap the poly'd player between them.

This works by making a new faction and filling its relations stats with the best of Player and the polymorph target. This means you won't lose the friendliness from your allies, rats (plage rats perk), or your polymorph target faction. It doesn't mean those things can't hurt you.

There's a slight caveat with the homing safety: your projectiles will home in on you for 1 frame. This shouldn't be a problem unless you stack homing modifiers.

Untested in multiplayer but it'll probably work fine.

## Installation instructions

 - Click the [Download ZIP button](https://github.com/Mamumimi/safer_polymorphing/archive/refs/heads/main.zip)
 - Extract into your Noita mods folder: '.../Steam/steamapps/common/Noita/mods/'
 - Make sure the folder with the mod files is called: 'safer_polymorphing'
 - Filepath to init.lua should be: '.../Noita/mods/safer_polymorphing/init.lua'
 - Enable the mod in Noita's mod menu.

Not yet on Steam Workshop: [Safer Polymorphing](https://github.com/Mamumimi/safer_polymorphing/archive/refs/heads/main.zip)
