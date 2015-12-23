function zoomout()
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
        dragDrop(topLeft, find("chat.png"))
    end
end

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
