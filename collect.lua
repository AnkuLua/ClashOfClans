-- ========== Settings ================
Settings:setCompareDimension(true, 1280)
Settings:setScriptDimension(true, 1280)
setImmersiveMode(true)
localPath = scriptPath()
dofile(localPath.."lib/COCLib.lua")
Settings:set("MinSimilarity", 0.7)
setHighlightStyle(0xffffff00, true)
-- ==========  main program ===========
center = Region(100, 100, 1080, 600)
upgradeLocation = Location(640, 550)
alive = Location(300, 160) -- keep the game alive
reload = Location(640, 440)
collectItems = {"goldCollect.png", "goldCollect2.png",
    "elixirCollect.png", "elixirCollect2.png", "elixirCollect3.png",
    "darkElixirCollect.png"}

collectCount = 1
reloadCount = 0

while (true) do
    zoomout()
    while (true) do

        -- click on all gold and elixir
        -- The pictures are small. Need different pictures to prevent misssing them.
        for i, r in ipairs(collectItems) do
            existsClickAll(r)
        end
        click(alive)

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