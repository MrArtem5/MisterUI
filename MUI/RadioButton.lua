--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local RadioButton = {}

function RadioButton.new(x, y, size, text, group, checked, callback, circleColor, checkColor, textColor)
    local self = {}
    self.x = x or 0
    self.y = y or 0
    self.size = size or 20
    self.text = text or ""
    self.group = group or "default"
    self.checked = checked or false
    self.callback = callback or function() end
    self.circleColor = circleColor or {0.3, 0.3, 0.4}
    self.checkColor = checkColor or {0.3, 0.8, 0.3}
    self.textColor = textColor or {1,1,1}
    self.enabled = true
    self.isHovered = false

    self.setChecked = function(rb, state)
        if not state then return end
        rb.checked = true
        if rb.callback then rb.callback(rb.checked) end
    end

    self.update = function(rb)
        if not rb.enabled then return end
        local mx, my = love.mouse.getPosition()
        local over = mx >= rb.x and mx <= rb.x + rb.size and my >= rb.y and my <= rb.y + rb.size
        if not over and rb.text ~= "" then
            local tw = love.graphics.getFont():getWidth(rb.text)
            over = mx >= rb.x + rb.size + 5 and mx <= rb.x + rb.size + 5 + tw and my >= rb.y and my <= rb.y + rb.size
        end
        rb.isHovered = over
        if love.mouse.isDown(1) and over and not rb.isPressed then
            rb.isPressed = true
        elseif rb.isPressed and not love.mouse.isDown(1) then
            rb.isPressed = false
            if over and not rb.checked then
                for _, other in ipairs(_G._MUI_RadioGroups[rb.group] or {}) do
                    if other ~= rb then other.checked = false end
                end
                rb.checked = true
                if rb.callback then rb.callback(rb.checked) end
            end
        end
    end

    self.draw = function(rb)
        if rb.enabled then
            love.graphics.setColor(rb.circleColor)
        else
            love.graphics.setColor(rb.circleColor[1]*0.5, rb.circleColor[2]*0.5, rb.circleColor[3]*0.5)
        end
        love.graphics.circle("line", rb.x + rb.size/2, rb.y + rb.size/2, rb.size/2)
        if rb.checked then
            if rb.enabled then
                love.graphics.setColor(rb.checkColor)
            else
                love.graphics.setColor(rb.checkColor[1]*0.5, rb.checkColor[2]*0.5, rb.checkColor[3]*0.5)
            end
            love.graphics.circle("fill", rb.x + rb.size/2, rb.y + rb.size/2, rb.size/4)
        end
        if rb.text ~= "" then
            if rb.enabled then
                love.graphics.setColor(rb.textColor)
            else
                love.graphics.setColor(rb.textColor[1]*0.5, rb.textColor[2]*0.5, rb.textColor[3]*0.5)
            end
            love.graphics.print(rb.text, rb.x + rb.size + 5, rb.y + (rb.size - love.graphics.getFont():getHeight())/2)
        end
    end

    self.setEnabled = function(rb, en) rb.enabled = en end
    self.setPosition = function(rb, nx, ny) rb.x = nx or rb.x; rb.y = ny or rb.y end

    _G._MUI_RadioGroups = _G._MUI_RadioGroups or {}
    _G._MUI_RadioGroups[self.group] = _G._MUI_RadioGroups[self.group] or {}
    table.insert(_G._MUI_RadioGroups[self.group], self)

    return self
end

return RadioButton















--[[
Создатель библиотеки - MrArtem.
Если вам продали библиотеку не от имени MrArtem'а
или пытались выдать себя за MrArtem'а
то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
Ведь продавец этой библиотеки мог добавить вредоносный файл.
ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
на проверенных источниках.
--]]