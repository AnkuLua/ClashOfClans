--========== regions setting ================
battleRegion = Region(100, 70, 1080, 680)


function zoomout()
    local attack  = find("attack.png"):getTarget()
    local shop = find("shop.png"):getTarget()
    local swipeFrom = Location(attack:getX(), attack:getY()-70)
    local swipeTo = Location(attack:getX(), attack:getY() - 500)
    swipe(swipeFrom, swipeTo)
    wait(1)
    swipe(swipeFrom, swipeTo)
    wait(1)
    swipe(swipeFrom, swipeTo)
    wait(1)

    local zoom1From = Location(attack:getX() + 70, attack:getY())
    local zoom1To = Location(540, zoom1From:getY())
    local zoom2From = Location(shop:getX() - 70, shop:getY())
    local zoom2To = Location(740, zoom1From:getY())
--    zoom(150, 700, 540, 700, 1130, 700, 740, 700, 150)
    zoom(zoom1From:getX(), zoom1From:getY(), zoom1To:getX(), zoom1To:getY(),
        zoom2From:getX(), zoom2From:getY(), zoom2To:getX(), zoom2To:getY(), 250)
    wait(1)
    zoom(zoom1From:getX(), zoom1From:getY(), zoom1To:getX(), zoom1To:getY(),
        zoom2From:getX(), zoom2From:getY(), zoom2To:getX(), zoom2To:getY(), 250)
    wait(1)
    zoom(zoom1From:getX(), zoom1From:getY(), zoom1To:getX(), zoom1To:getY(),
        zoom2From:getX(), zoom2From:getY(), zoom2To:getX(), zoom2To:getY(), 250)

    wait(1)
    dragDrop(swipeTo, Location(attack:getX(), 300))
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

-- ============= strings related ================
function fileExists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
end

function loadStrings(path)
    local language = getLanguage()
    local file = path.."strings."..getLanguage()..".lua";
    if (fileExists(file)) then
        dofile(file)
    else
        if (fileExists(path.."strings.lua")) then
            dofile(path.."strings.lua")
        end
    end
end

function tableLookup(table, item)
    for i, t in ipairs(table) do
        if (t == item) then return i end
    end
    return -1
end