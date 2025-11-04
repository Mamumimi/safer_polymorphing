# Safer Polymorphing

Ideally, your allies and homing projectiles won't turn on you when you get polymorphed. But it doesn't work.

The idea is to change the polymorph target's faction to one that's a hybrid of the friendliest relations between the player and what you polymorphed into, and also remove the tags "homing" and "enemy" from the polymorph target.

I've since found out that you probably can't use ModTextFileSetContent() outside of init but it's failing before that so... We'll get there when we get there.

I'll probably just do OnModPostInit() and copy every single faction into poly_$faction. csv bloat fr fr, exponential growth yipee

## Installation instructions

 - Don't, it doesn't work.