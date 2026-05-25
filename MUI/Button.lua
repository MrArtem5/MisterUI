--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local Button = {}

function Button.new(x, y, width, height, text, callback, basicColor, pressedColor, hoveredColor, borderColor, textColor)
    local self = {}

    self.x = x or 0
    self.y = y or 0
    self.width = width or 100
    self.height = height or 50
    self.text = text or "..."
    self.callback = callback or function() end

    self.isHovered = false
    self.isPressed = false
    
    self.basicColor = basicColor or {0.4, 0.4, 0.4}
    self.pressedColor = pressedColor or {0.2, 0.2, 0.2}
    self.hoveredColor = hoveredColor or {0.3, 0.3, 0.3}
    self.borderColor = borderColor or {0.15, 0.15, 0.15}
    self.textColor = textColor or {0.85, 0.85, 0.85}

    self.enabled = true
    
    self.setEnabled = function(btn, enabled)
        btn.enabled = enabled
        if not enabled then
            btn.isPressed = false
            btn.isHovered = false
        end
    end
    
    self.setPosition = function(btn, newX, newY)
        btn.x = newX or btn.x
        btn.y = newY or btn.y
    end
    
    self.getPosition = function(btn)
        return btn.x, btn.y
    end
    
    self.setSize = function(btn, newWidth, newHeight)
        btn.width = newWidth or btn.width
        btn.height = newHeight or btn.height
    end
    
    self.getSize = function(btn)
        return btn.width, btn.height
    end
    
    self.setText = function(btn, newText)
        btn.text = newText or "..."
    end
    
    self.getText = function(btn)
        return btn.text
    end

    self.update = function(btn)
        local mx, my = love.mouse.getPosition()
        btn.isHovered = mx >= btn.x and mx <= btn.x + btn.width and
                        my >= btn.y and my <= btn.y + btn.height

        if not btn.enabled then
            return
        end
        
        if btn.isPressed and not love.mouse.isDown(1) then
            btn.isPressed = false
            if btn.isHovered then
                btn.callback()
            end
        elseif not btn.isPressed and love.mouse.isDown(1) and btn.isHovered then
            btn.isPressed = true
        end
    end

    self.draw = function(btn)
        if not btn.enabled then
            local gray = (btn.basicColor[1] + btn.basicColor[2] + btn.basicColor[3]) / 3
            love.graphics.setColor(gray * 0.6, gray * 0.6, gray * 0.6)
        elseif btn.isPressed then
            love.graphics.setColor(btn.pressedColor)
        elseif btn.isHovered then
            love.graphics.setColor(btn.hoveredColor)
        else
            love.graphics.setColor(btn.basicColor)
        end
        love.graphics.rectangle("fill", btn.x, btn.y, btn.width, btn.height)
        
        if not btn.enabled then
            love.graphics.setColor(btn.textColor[1] * 0.5, btn.textColor[2] * 0.5, btn.textColor[3] * 0.5)
        else
            love.graphics.setColor(btn.textColor)
        end
        
        local font = love.graphics.getFont()
        local tw = font:getWidth(btn.text)
        --[[
        Создатель библиотеки - MrArtem.
        Если вам продали библиотеку не от имени MrArtem'а
        или пытались выдать себя за MrArtem'а
        то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
        Ведь продавец этой библиотеки мог добавить вредоносный файл.
        ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
        на проверенных источниках.
        --]]
        local th = font:getHeight()
        love.graphics.print(btn.text,
            btn.x + (btn.width - tw) / 2,
            btn.y + (btn.height - th) / 2)
        
        if not btn.enabled then
            love.graphics.setColor(btn.borderColor[1] * 0.5, btn.borderColor[2] * 0.5, btn.borderColor[3] * 0.5)
        else
            love.graphics.setColor(btn.borderColor)
        end
        love.graphics.rectangle("line", btn.x, btn.y, btn.width, btn.height)
    end
    
    return self
end

return Button
