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
setHighlightStyle(0xffffff00, true)
-- ==========  main program ===========
center = Region(100, 100, 1080, 600)
upgradeLocation = Location(640, 550)
alive = Location(300, 160) -- keep the game alive
reload = Location(640, 440)
collectItems = {"goldCollect.png", "goldCollect2.png",
    "elixirCollect.png", "elixirCollect2.png", "elixirCollect3.png",
    "darkElixirCollect.png"}

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

        if (center:exists(Pattern("disconnect.png"):similar(0.8), 0)) then
            toast("Disconnected")
--            getLastMatch():highlight(5)
--            print(getLastMatch():getScore())
            do return end
            break
        end
        wait(1)
        click(alive)

    end

    while (true) do
        click(reload)
        wait(3)
        if (not center:exists(Pattern("disconnect.png"):similar(0.8), 5)) then break end
        toast("Disconnected")

        wait(60)
    end
    wait(5)
--    zoom(200, 600, 600, 400, 1000, 170, 700, 300, 50)

end