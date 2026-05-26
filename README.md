# MUI
Библиотека для LOVE2D сделанная для легкого создания UI. Находится в разработке.

Это библиотека создана, чтобы люди использующие движок LOVE2D могли очень легко и быстро создавать свой интерфейс программы.

Перед работой с библиотекой советую прочитать ВСЮ лицензию.

Как работать с Mister User Interface:
## BUTTON
```lua
local btn = Button.new(x, y, width, height, text, callback, basicColor, pressedColor, hoveredColor, borderColor, textColor)
```
- `btn:setEnabled(enabled)` - Enable/disable button
- `btn:setPosition(newX, newY)` - Set position
- `btn:getPosition()` - Get x, y
- `btn:setSize(newWidth, newHeight)` - Set size
- `btn:getSize()` - Get width, height
- `btn:setText(newText)` - Change button text
- `btn:getText()` - Get current text
- `btn:update(dt)` - Update hover/press state
- `btn:draw()` - Draw button

## CHECKBOX
```lua
local cb = CheckBox.new(x, y, size, text, checked, callback, boxColor, checkColor, textColor, borderColor)
```
- `cb:setEnabled(enabled)` - Enable/disable
- `cb:setChecked(checked)` - Set checked state
- `cb:getChecked()` - Get checked state
- `cb:setText(newText)` - Set label text
- `cb:getText()` - Get label text
- `cb:setPosition(newX, newY)` - Set position
- `cb:setSize(newSize)` - Set box size
- `cb:getSize()` - Get box size
- `cb:toggle()` - Toggle checked state
- `cb:update(dt)` - Update state
- `cb:draw()` - Draw checkbox

## CIRCULAR PROGRESS
```lua
local cp = CircularProgress.new(x, y, radius, value, max, fgColor, bgColor, glow)
```
- `cp:setValue(v)` - Set current value (clamped 0-max)
- `cp:getValue()` - Get current value
- `cp:update(dt)` - Smooth value animation
- `cp:draw()` - Draw circular progress
- `cp:setPosition(nx, ny)` - Set position
- `cp:getPosition()` - Get position
- `cp:setSize(r)` - Set radius
- `cp:getSize()` - Get radius

## IMAGE BUTTON
```lua
local ib = ImageButton.new(x, y, width, height, normalImg, hoverImg, pressImg, callback)
```
- `ib:setEnabled(enabled)` - Enable/disable
- `ib:update(dt)` - Update state
- `ib:draw()` - Draw image button
- `ib:setPosition(nx, ny)` - Set position
- `ib:getPosition()` - Get position
- `ib:setSize(w, h)` - Set size
- `ib:getSize()` - Get size

## PANEL
```lua
local panel = Panel.new(x, y, width, height, color, borderColor, borderRadius)
```
- `panel:addChild(child)` - Add UI element as child
- `panel:removeChild(child)` - Remove child
- `panel:removeChildAtIndex(index)` - Remove by index
- `panel:clearChildren()` - Remove all children
- `panel:getChildren()` - Get children table
- `panel:getChildCount()` - Get number of children
- `panel:update(dt)` - Update all children
- `panel:draw()` - Draw panel and children
- `panel:isPointInside(px, py)` - Check if point inside
- `panel:setPosition(newX, newY)` - Set position (moves children)
- `panel:getPosition()` - Get position
- `panel:setVisible(visible)` - Show/hide panel
- `panel:isVisible()` - Get visibility
- `panel:setSize(newWidth, newHeight)` - Set size
- `panel:getSize()` - Get size
- `panel:setClipChildren(clip)` - Enable/disable clipping
- `panel:getClipChildren()` - Get clip state
- `panel:setColor(newColor)` - Set background color
- `panel:getColor()` - Get background color
- `panel:setBorderColor(newBorderColor)` - Set border color
- `panel:getBorderColor()` - Get border color
- `panel:bringToFront(child)` - Move child to front
- `panel:sendToBack(child)` - Move child to back

## PARALLAX PANEL
```lua
local pp = ParallaxPanel.new(x, y, width, height, layers, borderColor, borderRadius)
-- layers format: {{image, speedX, speedY, alpha}, ...}
```
- `pp:addChild(child)` - Add child element
- `pp:removeChild(child)` - Remove child
- `pp:update(dt)` - Update parallax and children
- `pp:draw()` - Draw parallax background and children
- `pp:setPosition(nx, ny)` - Set position
- `pp:getPosition()` - Get position
- `pp:setSize(w, h)` - Set size
- `pp:getSize()` - Get size

## PARTICLES EMITTER
```lua
local pe = ParticleEmitter.new()
```
- `pe:emit(x, y, count, config)` - Emit particles
  - config fields: speedMin, speedMax, angleMin, angleMax, lifetimeMin, lifetimeMax, sizeStart, sizeEnd, colorStart, colorEnd, gravity, spread
- `pe:update(dt)` - Update all particles
- `pe:draw()` - Draw all particles
- `pe:clear()` - Remove all particles

## PROGRESS BAR
```lua
local pb = ProgressBar.new(x, y, width, height, value, max, bgColor, fillColor, textColor, showPercent)
```
- `pb:setValue(v)` - Set current value
- `pb:getValue()` - Get current value
- `pb:setMax(m)` - Set maximum value
- `pb:draw()` - Draw progress bar
- `pb:setPosition(nx, ny)` - Set position

## RADIO BUTTON
```lua
local rb = RadioButton.new(x, y, size, text, group, checked, callback, circleColor, checkColor, textColor)
```
- `rb:setChecked(state)` - Set checked (only true works, auto-unsets others in group)
- `rb:update(dt)` - Update state
- `rb:draw()` - Draw radio button
- `rb:setEnabled(en)` - Enable/disable
- `rb:setPosition(nx, ny)` - Set position

## SCROLL PANEL
```lua
local sp = ScrollPanel.new(x, y, width, height, contentHeight, color, borderColor, borderRadius, scrollBarColor)
```
- `sp:setContentHeight(newHeight)` - Set scrollable area height
- `sp:getContentHeight()` - Get content height
- `sp:setScrollOffset(offset)` - Set scroll position
- `sp:getScrollOffset()` - Get scroll position
- `sp:scrollBy(delta)` - Scroll by amount
- `sp:addChild(child)` - Add child element
- `sp:removeChild(child)` - Remove child
- `sp:clearChildren()` - Remove all children
- `sp:update(dt)` - Update and handle mouse wheel
- `sp:draw()` - Draw scrolled content
- `sp:setPosition(nx, ny)` - Set position
- `sp:getPosition()` - Get position
- `sp:setSize(newWidth, newHeight)` - Set size
- `sp:getSize()` - Get size
- `sp:setVisible(visible)` - Show/hide
- `sp:isVisible()` - Get visibility

## SLIDER
```lua
local sl = Slider.new(x, y, width, height, minValue, maxValue, initial, orientation, bgColor, fillColor, thumbColor, showValue, step)
-- orientation: "horizontal" or "vertical"
```
- `sl:setValue(v)` - Set value (respects step)
- `sl:getValue()` - Get current value
- `sl:setCallback(cb)` - Set callback function
- `sl:update(dt)` - Update dragging state
- `sl:draw()` - Draw slider
- `sl:setEnabled(en)` - Enable/disable
- `sl:setPosition(nx, ny)` - Set position
- `sl:getPosition()` - Get position

## SPRITE (Animation)
```lua
local spr = Sprite.new(x, y, frameWidth, frameHeight, image, frameCount, fps, loop, onCycleEnd)
```
- `spr:play()` - Start playing animation
- `spr:stop()` - Stop animation
- `spr:pause()` - Pause animation
- `spr:resume()` - Resume animation
- `spr:update(dt)` - Update animation frame
- `spr:draw()` - Draw current frame
- `spr:setPosition(nx, ny)` - Set position
- `spr:getPosition()` - Get position
- `spr:setScale(sx, sy)` - Set scale
- `spr:getSize()` - Get frame width, height

## TEXT FIELD
```lua
local tf = TextField.new(x, y, width, height, placeholder, font, bgColor, borderColor, textColor, placeholderColor, maxLength, passwordChar)
```
- `tf:setEnabled(en)` - Enable/disable
- `tf:setText(newText)` - Set text content
- `tf:getText()` - Get current text
- `tf:update(dt)` - Update cursor blink
- `tf:draw()` - Draw text field
- `tf:textinput(text)` - Handle text input (call from love.textinput)
- `tf:keypressed(key, scancode, isrepeat)` - Handle keys (backspace, delete, arrows, ctrl+c/v/x)
- `tf:mousepressed(mx, my, button)` - Handle focus

## THEME MANAGER
```lua
local tm = ThemeManager.new()
```
- `tm:addTheme(name, theme)` - Add new theme
- `tm:setTheme(name)` - Activate theme
- `tm:getColor(key)` - Get color from active theme
- `tm:getFont(key)` - Get font from active theme

## TOOLTIP
```lua
local tt = Tooltip.new(text, font, bgColor, textColor, delay)
```
- `tt:setOwner(owner)` - Attach to UI element (uses isHovered property)
- `tt:update(dt)` - Update visibility timer
- `tt:draw()` - Draw tooltip if visible

## UI MANAGER
```lua
local ui = UIManager.new()
```
- `ui:add(elem, z)` - Add element with z-order
- `ui:remove(elem)` - Remove element
- `ui:update(dt)` - Update all elements
- `ui:draw()` - Draw all elements
- `ui:mousepressed(mx, my, button)` - Route mouse press
- `ui:textinput(text)` - Route text input to focused element
- `ui:keypressed(key, scancode, isrepeat)` - Route key press

## WINDOW
```lua
local win = Window.new(x, y, width, height, title, color, borderColor, titleColor, closeButton, draggable, resizable)
```
- `win:addChild(child)` - Add child element
- `win:removeChild(child)` - Remove child
- `win:update(dt)` - Update dragging and children
- `win:draw()` - Draw window and children
- `win:mousepressed(mx, my, button)` - Handle drag and close
- `win:setPosition(nx, ny)` - Set position
- `win:setSize(nw, nh)` - Set size
- `win:setVisible(vis)` - Show/hide window
- `win:setModal(modal)` - Set modal state

## LIST BOX
```lua
local lb = ListBox.new(x, y, width, height, items, bgColor, itemColor, selectedColor, textColor, itemHeight)
```
- `lb:addItem(item)` - Add item to list
- `lb:removeItem(index)` - Remove item by index
- `lb:clear()` - Remove all items
- `lb:setCallback(cb)` - Set selection callback
- `lb:update(dt)` - Update hover and scroll
- `lb:draw()` - Draw list box
- `lb:setPosition(nx, ny)` - Set position
