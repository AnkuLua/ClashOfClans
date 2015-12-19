function existsClickAll(target, seconds)
    if (not exists(target, seconds)) then return end
    usePreviousSnap(true)
    local all = findAll(target, 0)
    usePreviousSnap(false)
--    for i, r in ipairs(all) do
--        r:highlight()
--    end

--    wait(2)
--    for i, r in ipairs(all) do
--        r:highlight()
--    end
--
    for i, r in ipairs(all) do
        click(r)
    end
end

function upgrade(index) -- endtarget, startLevel, maxLevel)
    local target = upgradeItems[index]
    local maxLevel = upgradeMax[target]
    local level = upgradeLevel[target]
    local similar
    if (target == "elixirStorage") then
        similar = 0.5
    else
        similar = 0.7
    end

    toast(target..level..".png")
    wait(3)

    if (level > maxLevel) then do return end end

    if (existsClick(Pattern(target.."L"..level..".png"):similar(similar), 0)) then
        toast(target)
        getLastMatch():highlight(2)
        existsClick("upgrade.png")
        wait(1)
        click(upgradeLocation)
        if (not waitVanish("cancel.png", 2)) then -- not enough resource
            existsClick("cancel.png")
            wait(1)
            existsClick("cancel.png")
        end
        do return end
    end

    upgradeLevel[target] = level + 1

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
center = Region(100, 100, 1080, 600)
upgradeLocation = Location(640, 550)
alive = Location(300, 160) -- keep the game alive
collectItems = {"goldCollect.png", "goldCollect2.png",
    "elixirCollect.png", "elixirCollect2.png", "elixirCollect3.png",
    "darkElixirCollect.png"}
--upgradeItems = {"goldMine", "elixirCollector", "goldStorage", "elixirStorage", "barracks",
--    "armyCamp",          "cannon" }
upgradeItems = {"goldStorage", "elixirStorage" }
--upgradeItems = {"elixirStorage" }
upgradeMax = {}
upgradeMax["goldMine"] = 3
upgradeMax["elixirCollector"] = 6
upgradeMax["goldStorage"] = 5
upgradeMax["elixirStorage"] = 5
upgradeMax["barracks"] = 2
upgradeMax["armyCamp"] = 1
upgradeMax["cannon"] = 1
--upgradeMax   = {         3,                 3,             4,               3,          2,
--                         1,                 1 }
--upgradeLevel = {         1,                 1,             1,               1 }
upgradeIndex = 1
upgradeTotal = table.getn(upgradeItems)
upgradeLevel = {}
for i, r in ipairs(upgradeItems) do
    upgradeLevel[r] = 4
end

while (true) do
    --    zoom(200, 600, 600, 400, 1000, 170, 700, 300, 50)
    zoom(100, 285, 540, 285, 1180, 285, 740, 285, 50)
    wait(2)
    --    zoom(200, 600, 600, 400, 1000, 170, 700, 300, 50)
    zoom(100, 285, 540, 285, 1180, 285, 740, 285, 50)

--eraseStone()

    while (true) do

        -- click on all gold and elixir
        -- The pictures are small. Need different pictures to prevent misssing them.
        for i, r in ipairs(collectItems) do
            existsClickAll(r)
        end

        click(alive)
        if (not exists("builderZero.png")) then
            upgrade(upgradeIndex)
            if (upgradeIndex == upgradeTotal) then
                upgradeIndex = 1
            else
                upgradeIndex = upgradeIndex + 1
            end
            click(alive)
        end


        if (center:exists(Pattern("supercellLogo.png"):similar(0.8), 0)) then
            toast("Disconnected")
            --            getLastMatch():highlight(5)
            --            print(getLastMatch():getScore())
            do return end
            break
        end

        wait(1)
    end

    while (true) do
        click(reload)
        wait(3)
        if (not center:exists(Pattern("supercellLogo.png"):similar(0.8), 5)) then break end
        toast("Disconnected")

        wait(60)
    end
    wait(5)

end