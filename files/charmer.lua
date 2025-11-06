function split_string(inputstr, sep)
    sep = sep or "%s"
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

local applier_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(applier_id)
local player_id = EntityGetClosestWithTag(pos_x, pos_y, "polymorphed_player")   --this is why putting the applier near the player was important :)
if player_id then
    local genome_component = EntityGetFirstComponentIncludingDisabled(player_id, "GenomeDataComponent")
    if genome_component then --Copies relations from from_faction to poly_player. Definitely not the best way to code this but I just think it's neat.
        local genomeCSV = ModTextFileGetContent("data/genome_relations.csv")
        local lines = split_string(genomeCSV, "\r\n")
        local genome2D = {} -- The whole chart in one 2d table, available via y,x coords.
        for i, line in ipairs(lines) do
            genome2D[i] = split_string(line, ",")
        end
        local column = {} -- the first row lists all of the column names
        for x, cell in ipairs(genome2D[1]) do
            column[cell] = x -- going horizontally (x++) from y==1
        end
        local row = {} -- the first cell in each row is the name of the row.
        for y = 1, #genome2D do
            local cell = genome2D[y][1]:match("^%s*(.*)") -- trim the leading spaces or else lookup fails.
            row[cell] = y -- going vertically (y++) on x==1
        end
        local from_faction = genome2D[1][ComponentGetValue2(genome_component, "herd_id") + 2] -- The GetValue here gets the index and not the name. Also, the index starts at -1... This took hours to figure out because I am a fool.
        for x = 2, #genome2D[1] do -- replace poly_player row with from_faction row, skipping the faction name.
            ---@diagnostic disable-next-line: param-type-mismatch
            genome2D[row["poly_player"]][x] = math.max(tonumber(genome2D[row["player"]][x]),tonumber(genome2D[row[from_faction]][x])) -- Use the higher of player/from_faction relations so relations never decrease
        end
        for y = 2, #genome2D do -- replace poly_player column with from_faction column, skipping the faction name.
            ---@diagnostic disable-next-line: param-type-mismatch
            genome2D[y][column["poly_player"]] = math.max(tonumber(genome2D[y][column["player"]]),tonumber(genome2D[y][column[from_faction]])) -- Use the higher of player/from_faction relations so relations never decrease
        end -- This is the important one, the vertical columns are what enemies think of poly_player.
        local output, output_lines = "", {}
        for i, line in ipairs(genome2D) do
            output_lines[i] = table.concat(genome2D[i], ",") -- combine cells into lines
        end
        output = table.concat(output_lines, "\r\n") -- combine lines into the whole file
        ModTextFileSetContent("data/genome_relations.csv", output)
        ComponentSetValue2(genome_component, "herd_id", StringToHerdId("poly_player"))
        EntityRemoveTag(player_id, "homing_target")
        EntityRemoveTag(player_id, "enemy")
        --print("Player polymorphed into "..from_faction.."! Here's the new relations table:\n"..output.."\n")
    end
end
EntityKill(applier_id)
