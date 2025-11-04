function OnPlayerSpawned(player_id)
    local luaHomunculusComponents = EntityGetComponent(player_id, "LuaComponent", "homunculus_type")
    if luaHomunculusComponents then
        for _,component in ipairs(luaHomunculusComponents) do
            if ComponentGetValue2(component,"script_polymorphing_to") == "mods/safer_polymorphing/files/applier_entity_spawner.lua"
                then
                --GamePrintImportant("Already applied, skipping")
                return
            end
        end
    end
    --GamePrintImportant("Not found, initializing now")
    EntityAddComponent2( player_id, "LuaComponent", {
        execute_every_n_frame=-1,
        script_polymorphing_to="mods/safer_polymorphing/files/applier_entity_spawner.lua",
        _tags="homunculus_type"
    })
end

function OnModPostInit() -- I probably don't need to put this here but I'm gonna anyway because why not?
  -- Shamefully copied from More Enemies and Bosses  
  function split_string(inputstr, sep)
    sep = sep or "%s"
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
      table.insert(t, str)
    end
    return t
  end

  local content = ModTextFileGetContent("data/genome_relations.csv")
  --print("Here's the default genome:\n"..content.."\n")
  function add_new_genome(content, genome_name, default_relation_ab, default_relation_ba, self_relation, relations)
    local lines = split_string(content, "\r\n")
    local output = ""
    local genome_order = {}
    for i, line in ipairs(lines) do
      if i == 1 then
        output = output .. line .. "," .. genome_name .. "\r\n"
      else
        local herd = line:match("([%w_-]+),")
        output = output .. line .. "," .. (relations[herd] or default_relation_ba) .. "\r\n"
        table.insert(genome_order, herd)
      end
    end

    local line = genome_name
    for i, v in ipairs(genome_order) do
      line = line .. "," .. (relations[v] or default_relation_ab)
    end
    output = output .. line .. "," .. self_relation

    return output
  end

  content = add_new_genome(content, "poly_player", 100, 100, 100, {})

  ModTextFileSetContent("data/genome_relations.csv", content)
  --print("Here's the updated genome:\n" .. content.."\n")
end
