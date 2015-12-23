
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

    if (level < maxLevel) then
        upgradeLevel[target] = level + 1
    end

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
localPath = scriptPath()
dofile(localPath.."lib/COCLib.lua")
Settings:set("MinSimilarity", 0.7)
-- ==========  main program ===========
center = Region(100, 100, 1080, 600)
upgradeLocation = Location(640, 550)
alive = Location(300, 160) -- keep the game alive
reload = Location(640, 440)
collectItems = {"goldCollect.png", "goldCollect2.png",
    "elixirCollect.png", "elixirCollect2.png", "elixirCollect3.png",
    "darkElixirCollect.png"}
--upgradeItems = {"goldMine", "elixirCollector", "goldStorage", "elixirStorage", "barracks",
--    "armyCamp",          "cannon" }
upgradeItems = {"goldMine", "elixirStorage" }
--upgradeItems = {"research"} --, "elixirStorage" }
--upgradeItems = {"elixirStorage" }
upgradeMax = {}
upgradeMax["goldMine"] = 3
upgradeMax["elixirCollector"] = 6
upgradeMax["goldStorage"] = 11
upgradeMax["elixirStorage"] = 11
upgradeMax["barracks"] = 2
upgradeMax["armyCamp"] = 1
upgradeMax["cannon"] = 1
upgradeMax["research"] = 2
--upgradeMax   = {         3,                 3,             4,               3,          2,
--                         1,                 1 }
--upgradeLevel = {         1,                 1,             1,               1 }
upgradeIndex = 1
upgradeTotal = table.getn(upgradeItems)
upgradeLevel = {}
for i, r in ipairs(upgradeItems) do
    upgradeLevel[r] = 1 --0 -- 4
end

collectCount = 1
reloadCount = 0

while (true) do
    zoomout()

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
            getLastMatch():highlight(2)
            toast("Disconnected")
            break
        end

        toast("Collect count: " .. collectCount .. "\nReload count: " .. reloadCount)
        collectCount = collectCount + 1
        wait(1)

    end

    while (true) do
        click(reload)
        wait(1)
        click(alive)
        wait(1)
--        if (not center:exists(Pattern("supercellLogo.png"):similar(0.8), 5)) then break end
        if (exists("trophy.png", 5)) then break end
        toast("Disconnected")

        wait(5) --60)
    end

    click(alive)
    while (existsClick("cancel.png", 0)) do
        wait(1)
    end
    wait(1)
    click(alive)


    reloadCount = reloadCount + 1
--    exists("trophy.png", 15)

end