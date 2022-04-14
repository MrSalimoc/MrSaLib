local _libButtons = {}

function createButton(text, minX, minY, maxX, maxY, buttonType, color, clickCallback, defaultState)
    local _newButton = {}
    _newButton.id = table.maxn(_libButtons) + 1
    _newButton.text = text
    _newButton.minX = minX
    _newButton.minY = minY
    _newButton.maxX = maxX - 1
    _newButton.maxY = maxY - 1
    _newButton.buttonType = buttonType
    _newButton.color = color
    _newButton.clickCallback = clickCallback
    if buttonType == "toggle" then
        if defaultState == true then
            _newButton.toggled = true
        elseif defaultState == false then
            _newButton.toggled = false
        else
            _newButton.toggled = true
        end
    end
    table.insert(_libButtons, _newButton)
end

function _drawButtons(bool)
    for k,v in ipairs(_libButtons) do
        term.setCursorPos(v.minX, v.minY)
        if v.buttonType == "toggle" then
            if v.toggled then
                term.setBackgroundColor(v.color)
            elseif v.toggled == true then
                term.setBackgroundColor(v.color)
            elseif v.toggled == false then
                term.setBackgroundColor(colors.gray)
            end
        else
            term.setBackgroundColor(v.color)
        end
        for x = v.minX, v.minX + v.maxX do            
            for y = v.minY, v.minY + v.maxY do
                term.setCursorPos(x, y)
                print(" ")
            end
        end
        local textPos = v.maxX - #v.text
        term.setCursorPos(v.minX + textPos / 2, v.minY + v.maxY / 2)
        print(v.text)
        term.setBackgroundColor(colors.black)
    end
end

function _getClickedButton(posX, posY)
    for k,v in ipairs(_libButtons) do
        if posX >= v.minX and posX <= v.minX + v.maxX then
            if posY >= v.minY and posY <= v.minY + v.maxY then
                return v.id
            end
        end
    end
end

function setButtonText(buttonId, text)
    for k,v in ipairs(_libButtons) do
        if buttonId == v.id then
            v.text = text
        end
    end
end

function onClick(event)
    local clickedButton = _getClickedButton(event[3], event[4])
    for k,v in ipairs(_libButtons) do
        if clickedButton == v.id then
            v.clickCallback(v)
            if v.buttonType == "toggle" and v.toggled == false then
                v.toggled = true
            else
                v.toggled = false
            end
            _drawButtons(true)
        end
    end
end

--function testButton()
--    term.setCursorPos(40,40)
--    print("print")
--end

--createButton("test", 40, 1, 5, 5, "toggle", colors.green, testButton)
--createButton("test2", 6, 6, 11, 11, "normal", colors.red)
--createButton("svya", 21, 32, 20, 3, "normal", colors.magenta)
--_drawButtons(true)


--while true do
--onClick({os.pullEvent("mouse_click")})

--_drawButtons(true)
--end
