--========== regions setting ================
battleRegion = Region(100, 70, 1080, 680)


function zoomout()
    local attack  = find("attack,png")
    local shop = find("shop.png")
    swipe(Location(640, 700), Location(640,150))
    wait(1)
    swipe(Location(640, 700), Location(640,150))
    wait(1)
    swipe2(Location(640, 700), Location(640,150))
    wait(1)

    zoom(150, 700, 540, 700, 1130, 700, 740, 700, 150)
    wait(2)
    zoom(150, 700, 540, 700, 1130, 700, 740, 700, 150)

    if (exists("centerLeftCorner.png")) then
        dragDrop(getLastMatch(), find("chat.png"))
        do return end
    end

    if (exists("centerLeftCorner2.png")) then
        toast("centerLeftCorner2")
        local topLeft = Location(getLastMatch():getX() + 50, getLastMatch():getY())
        dragDrop(topLeft, Pattern("chat.png"):targetOffset(70, 0))
    end
end

function existsClickAll(target, seconds)
    if (not battleRegion:exists(target, seconds)) then return end
    usePreviousSnap(true)
--    battleRegion = Region(100, 70, 1080, 680)
    local allTable = battleRegion:findAll(target)
    local all = listToTable(allTable)
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

function waitMulti(target, seconds)
    local timer = Timer()
    while (true) do
        for i, t in ipairs(target) do
            if (exists(t, 0)) then -- check once
            return i, getLastMatch()
            end
        end
        if (timer:check() > seconds) then return -1 end
    end
end

function waitMultiClick(target, seconds)
    local timer = Timer()
    while (true) do
        for i, t in ipairs(target) do
            if (existsClick(t, 0)) then -- check once
            return i, getLastMatch()
            end
        end
        if (timer:check() > seconds) then return -1 end
    end
end

function simpleDialog(title, message)
    dialogInit()
    addTextView(message)
    dialogShow(title)
end