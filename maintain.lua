function existsClickAll(target, seconds)
    if (not exists(target, seconds)) then return end
    usePreviousSnap(true)
    local all = findAll(target, 0)
    usePreviousSnap(false)
    for i, r in ipairs(all) do
        r:highlight()
    end

--    wait(2)
--    for i, r in ipairs(all) do
--        r:highlight()
--    end
--
--    for i, r in ipairs(all) do
--        click(r)
--    end
end

function upgrade(index) -- endtarget, startLevel, maxLevel)
    local target = upgradeItems[index].."L"
    local maxLevel = upgradeMax[index]
    local level = upgradeLevel[index]

    toast(target..level..".png")
    wait(3)

    if (level > maxLevel) then do return end end

    if (existsClick(Pattern(target..level..".png"):similar(0.8), 0)) then
        toast(target)
        getLastMatch():highlight(2)
        click("upgrade.png")
        wait(1)
        click(upgradeLocation)
        if (not waitVanish("cancel.png", 2)) then -- not enough resource
            existsClick("cancel.png")
            wait(1)
            existsClick("cancel.png")
        end
        do return end
    end

    upgradeLevel[index] = level + 1

end

function eraseStone() -- stone is similar to dark elixir. erase them to avoid confusion
    setHighlightStyle(0xffffff00, true)
    if (not exists(Pattern("stone.png"):similar(0.9), 0)) then return end
    usePreviousSnap(true)
    local all = findAll(Pattern("stone.png"):similar(0.9), 0)
    usePreviousSnap(false)
    for i, t in ipairs(all) do
        t:highlight()
    end
    wait(1)
end

-- ========== Settings ================
Settings:setCompareDimension(true, 1280)
Settings:setScriptDimension(true, 1280)
setImmersiveMode(true)
Settings:set("MinSimilarity", 0.7)
-- ==========  main program ===========
upgradeLocation = Location(640, 550)
collectItems = {"goldCollect.png", "goldCollect2.png",
    "elixirCollect.png", "elixirCollect2.png", "elixirCollect3.png",
    "darkElixirCollect.png"}
upgradeItems = {"goldMine", "elixirCollector", "goldStorage", "elixirStorage", "barracks",
                "armyCamp",          "cannon"}
upgradeMax   = {         3,                 3,             4,               3,          2,
                         1,                 1 }
upgradeLevel = {         1,                 1,             1,               1 }
upgradeIndex = 1
upgradeTotal = table.getn(upgradeItems)
for i = 1, upgradeTotal do
    upgradeLevel[i] = 1
end

zoom(200, 600, 600, 400, 1000, 170, 700, 300, 50)
--eraseStone()

while (true) do

    -- click on all gold and elixir
    -- The pictures are small. Need different pictures to prevent misssing them.
    for i, r in ipairs(collectItems) do
        existsClickAll(r)
    end

--    if (not exists("builderZero.png")) then
--        upgrade(upgradeIndex)
--        if (upgradeIndex == upgradeTotal) then
--            upgradeIndex = 1
--        else
--            upgradeIndex = upgradeIndex + 1
--        end
--    end


    wait(5)
end
