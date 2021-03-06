# MrSaLib 1.0
MrSaLib is a Computer Craft (CC:Tweaked) API adding a fast and simple way to create GUI on computers in Minecraft.

## Install
You can install the lib with the following command inside Computer terminal.
```
pastebin get jZN0hUQG mrsalib.lua
```
In order to make it work in your program you'll need thoses lines:
```LUA
os.loadAPI("mrsalib.lua")

while true do
    mrsalib._drawButtons(true)
    mrsalib.onClick({os.pullEvent("mouse_click")})
end
```
### Example
Here an example of a button in the center of the screen. When toggled on, it will power redstone from the back of the computer.  
In order to make it work in your program you'll need thoses lines (`pastebin get 8Hm0Br0n example`):
```LUA
os.loadAPI("mrsalib.lua")
local maxX, maxY = term.getSize()
local outputSignal = false

function setRedstone()
    if outputSignal == false then
        redstone.setOutput("back", true)
        outputSignal = true
    else
        redstone.setOutput("back", false)
        outputSignal = false
    end
end

-- mrsalib._setMonitor(side) for monitor support
mrsalib.createButton("Redstone", maxX / 2 - 10, maxY / 2 - 3, 20, 5, "toggle", colors.red, setRedstone)

while true do
    mrsalib._drawButtons(true)
    mrsalib.onClick({os.pullEvent("mouse_click")}) -- change for "monitor_touch" if using _setMonitor(side)
end
```

# Functions

## createButton
  **Description:**

  > Draw a rectangle acting like a button

  **Parameters:**

  ```
  (text, minX, minY, maxX, maxY, buttonType, color, clickCallback)
  ```

  `text` The text of the button  
  `minX` The ***x*** coordinate where the button should start  
  `minY` The ***y*** coordinate where the button should start  
  `maxX` The length of the button on the ***x*** axis  
  `maxY` The length of the button on the ***y*** axis  
  `buttonType` The type of the button (`normal | toggle`)  
  `color` The color of the button using [Colors API](https://www.computercraft.info/wiki/Colors_(API))  
  `clickCallback` The callback pointer *(you can get button data by getting it from param)*  

  **Return Values:**

  > true on success, nil on failure.

  ```LUA
  function testButton()
    redstone.setOutput("back", true)
  end

  createButton("Button", 2, 2, 10, 3, "normal", colors.red, testButton)
  
  -- The red button should turn on the redstone signal at the back of the computer when clicked
  ```
<hr>

## createLabel
  **Description:**

  > Draw a rectangle for printing text or dynamic values

  **Parameters:**

  ```
  (text, minX, minY, maxX, maxY, labelType, color, value)
  ```

  `text` The text of the label  
  `minX` The ***x*** coordinate where the label should start  
  `minY` The ***y*** coordinate where the label should start  
  `maxX` The length of the label on the ***x*** axis  
  `maxY` The length of the label on the ***y*** axis  
  `labelType` The type of the label (`text | number | both`)  
  `color` The color of the label using [Colors API](https://www.computercraft.info/wiki/Colors_(API))  
  `value` The value of the label

  **Return Values:**

  > true on success, nil on failure.

  ```LUA
  --TODO

  createLabel("Label", 2, 2, 10, 3, "both", colors.magenta, 10)
  
  -- The magenta label should print both "Label" and "10"
  ```
<hr>

# Internal Functions

## _drawButtons
  **Description:**

  > Draw every created buttons

  **Parameters:**

  ```
  (bool)
  ```

  `bool` The boolean choosing whether or not the buttons can be visible  

  **Return Values:**

  > true on success, nil on failure.

  ```LUA
  _drawButtons(true) -- The buttons will be visible
  _drawButtons(false) -- The buttons will not be visible
  ```
<hr>

## _getClickedButton
  **Description:**

  > Get the clicked button

  **Parameters:**

  ```
  (posX, posY)
  ```

  `posX` The ***x*** position to check  
  `posY` The ***y*** position to check  

  **Return Values:**

  > Button Name on success, nil on failure.

  ```LUA
  function testButton()
    redstone.setOutput("back", true)
  end

  createButton("Button", 2, 2, 10, 3, "normal", colors.red, testButton)
  
  while true do
    mouseClickEvent = {os.pullEvent("mouse_click")} -- Check CC wiki to know how events work (https://computercraft.info/wiki/Category:Events)
    local button = _getClickedButton(mouseClickEvent[3], mouseClickEvent[4]) -- Returns the button name
    print(button) -- Should return "Button"
  end
  ```
<hr>

## onClick
  **Description:**

  > Fire on each click on the screen

  **Parameters:**

  ```
  (event)
  ```

  `event` The table containing the `mouse_click` event data  

  **Return Values:**

  > true on success, nil on failure.

  ```LUA
  -- No need in code, it's an internal function
  ```
<hr>