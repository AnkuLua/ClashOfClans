
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

    if (battleRegion:existsClick(Pattern(target.."L"..level..".png"):similar(similar), 0)) then
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

function training()
    if unexpected_condition then error() end

    trained = true
    click(alive)
    local choice = waitMultiClick({"barracksTop.png", "barracksL1.png", "barracksL2.png"})
    if (choice ~= -1) then
        if (existsClick("trainTroops.png")) then
            exists("barracksChoose.png")
            local allBarracks = findAll(Pattern("barracksChoose.png"):similar(0.55))
            for i, b in ipairs(allBarracks) do
                click(b)
                wait(2)
                --                        toast(trainingItems[i]..".png  : "..i)
                if (exists(trainingItems[i]..".png")) then
                    getLastMatch():highlight(1)
                    longClick(getLastMatch(), 5)
                end
            end
        end
    end
    existsClick("cancel.png")
    click(alive)
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
alive = Location(370, 70) --(300, 160) -- keep the game alive
reload = Location(640, 440)
collectItems = {"goldCollect.png", "goldCollect2.png",
    "elixirCollect.png", "elixirCollect2.png", "elixirCollect3.png",
    "darkElixirCollect.png"}
--upgradeItems = {"goldMine", "elixirCollector", "goldStorage", "elixirStorage", "barracks",
--    "armyCamp",          "cannon" }
upgradeItems = {"elixirCollector", "goldMine" }
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

allItems = {"None", "goldMine", "goldStorage", "elixirCollector", "elixirStorage",
            "barracks", "cannon", "research" }
allTroops = {"barbarian", "archer", "giant", "goblin", "wallBreaker",
             "balloon", "wizard", "healer", "dragon", "PEKKA"}
-- =================== dialog ===============
dialogInit()
addCheckBox("upgrade", "Upgrade", false)
newRow()
addSpinner("upgradeItem1", allItems, "None")
newRow()
addSpinner("upgradeItem2", allItems, "None")
newRow()
addTextView("")
newRow()
addCheckBox("training", "Training Troops", true)
newRow()
addTextView("Troop to train in barracks 1")
addSpinner("training1", allTroops, "barbarian")
newRow()
addTextView("Troop to train in barracks 2")
addSpinner("training2", allTroops, "barbarian")
newRow()
addTextView("Troop to train in barracks 3")
addSpinner("training3", allTroops, "barbarian")
newRow()
addTextView("Troop to train in barracks 4")
addSpinner("training4", allTroops, "barbarian")
--newRow()
--addTextView("Troop to train in barracks 5")
--addSpinner("training5", allTroops, "barbarian")
--newRow()
--addTextView("Troop to train in barracks 6")
--addSpinner("training6", allTroops, "barbarian")
--newRow()
--addTextView("Troop to train in barracks 7")
--addSpinner("training7", allTroops, "barbarian")
--newRow()
--addTextView("Troop to train in barracks 8")
--addSpinner("training8", allTroops, "barbarian")

dialogShow("Choose actions")

upgradeItems = {upgradeItem1, upgradeItem2}
trainingItems = {training1, training2, training3, training4} --, training5, training6, training7, training8}


-- ==========================================
collectCount = 1
reloadCount = 0
trained = false

while (true) do
    click(alive)
    zoomout()

--eraseStone()

    while (true) do

        -- click on all gold and elixir
        -- The pictures are small. Need different pictures to prevent misssing them.
        for i, r in ipairs(collectItems) do
            existsClickAll(r, 0)
            click(alive)
        end
        click(alive)
        existsClick("returnHome.png", 0)

        if (upgrade and not exists("builderZero.png")) then
            upgrade(upgradeIndex)
            if (upgradeIndex == upgradeTotal) then
                upgradeIndex = 1
            else
                upgradeIndex = upgradeIndex + 1
            end
            click(alive)
        end

        if (training) then
            if (pcall (training)) then
            else
                click(alive)
            end
        end

        if (center:exists(Pattern("supercellLogo.png"):similar(0.8), 0)) then
            getLastMatch():highlight(2)
            toast("Disconnected")
            break
        end

        toast("Collect count: " .. collectCount .. "\nReload count: " .. reloadCount)
        collectCount = collectCount + 1
        wait(60)

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