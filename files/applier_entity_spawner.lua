function polymorphing_to(player_id)
	local pos_x, pos_y = EntityGetTransform(player_id) --not necessary for singleplayer, but kept for multiplayer to make sure the poly'd player gets charmed instead of whoever is closest to 0,0
	EntityLoad("mods/safer_polymorphing/files/applier_entity.xml", pos_x, pos_y) -- These applier entity shenanigans are necessary to add a 1 frame delay because it's apparently not possible to manipulate the player on the same frame they're getting polymorphed.
end
