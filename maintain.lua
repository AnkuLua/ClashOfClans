function existsClickAll(target, seconds)
    if (not exists(target, seconds)) then return end
    local all = findAll(target, 0)
--    for i, r in ipairs(all) do
--        r:highlight()
--    end
--
--    wait(2)
--    for i, r in ipairs(all) do
--        r:highlight()
--    end

    for i, r in ipairs(all) do
        click(r)
    end
end

        -- ========== Settings ================
Settings:setCompareDimension(true, 1280)
Settings:setScriptDimension(true, 1280)
setImmersiveMode(true)
Settings:set("MinSimilarity", 0.7)
-- ==========  main program ===========

while (true) do

    -- click on all gold and elixir
    -- The pictures are small. Need different pictures to prevent misssing them.
    existsClickAll("goldCollect.png", 0)
    existsClickAll("goldCollect2.png", 0)
--    existsClickAll("goldCollect3.png", 0)
    existsClickAll("elixirCollect.png", 0)
    existsClickAll("elixirCollect2.png", 0)
    existsClickAll("elixirCollect3.png", 0)
    wait(1)
end
