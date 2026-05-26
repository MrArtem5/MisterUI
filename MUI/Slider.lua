--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local Slider = {}

function Slider.new(x, y, width, height, minValue, maxValue, initial, orientation, bgColor, fillColor, thumbColor, showValue, step)
    local self = {}
    self.x = x or 0
    self.y = y or 0
    self.width = width or 200
    self.height = height or 20
    self.min = minValue or 0
    self.max = maxValue or 100
    self.value = math.min(math.max(initial or self.min, self.min), self.max)
    self.orientation = orientation or "horizontal"
    self.bgColor = bgColor or {0.2, 0.2, 0.3}
    self.fillColor = fillColor or {0.3, 0.7, 0.9}
    self.thumbColor = thumbColor or {0.9, 0.9, 1}
    self.showValue = showValue or false
    self.step = step or 1
    self.callback = nil

    self.dragging = false
    self.enabled = true

    self.setValue = function(sl, v)
        v = math.min(math.max(v, sl.min), sl.max)
        if sl.step > 0 then
            v = math.floor((v - sl.min) / sl.step) * sl.step + sl.min
        end
        sl.value = v
        if sl.callback then sl.callback(sl.value) end
    end

    self.getValue = function(sl) return sl.value end

    self.setCallback = function(sl, cb) sl.callback = cb end

    self.update = function(sl, dt)
        if not sl.enabled then return end
        local mx, my = love.mouse.getPosition()
        if sl.dragging then
            if not love.mouse.isDown(1) then
                sl.dragging = false
                return
            end
            local t
            if sl.orientation == "horizontal" then
                t = (mx - sl.x) / sl.width
            else
                t = (my - sl.y) / sl.height
            end
            t = math.min(math.max(t, 0), 1)
            local newVal = sl.min + t * (sl.max - sl.min)
            sl:setValue(newVal)
        else
            local over = mx >= sl.x and mx <= sl.x + sl.width and my >= sl.y and my <= sl.y + sl.height
            if love.mouse.isDown(1) and over then
                sl.dragging = true
                local t
                if sl.orientation == "horizontal" then
                    t = (mx - sl.x) / sl.width
                else
                    t = (my - sl.y) / sl.height
                end
                t = math.min(math.max(t, 0), 1)
                local newVal = sl.min + t * (sl.max - sl.min)
                sl:setValue(newVal)
            end
        end
    end

    self.draw = function(sl)
        love.graphics.setColor(sl.bgColor)
        if sl.orientation == "horizontal" then
            love.graphics.rectangle("fill", sl.x, sl.y, sl.width, sl.height, 4)
            local fillW = ((sl.value - sl.min) / (sl.max - sl.min)) * sl.width
            love.graphics.setColor(sl.fillColor)
            love.graphics.rectangle("fill", sl.x, sl.y, fillW, sl.height, 4)
            local thumbX = sl.x + fillW - sl.height/2
            love.graphics.setColor(sl.thumbColor)
            love.graphics.circle("fill", thumbX, sl.y + sl.height/2, sl.height/2)
        else
            love.graphics.rectangle("fill", sl.x, sl.y, sl.width, sl.height, 4)
            local fillH = ((sl.value - sl.min) / (sl.max - sl.min)) * sl.height
            love.graphics.setColor(sl.fillColor)
            love.graphics.rectangle("fill", sl.x, sl.y + sl.height - fillH, sl.width, fillH, 4)
            local thumbY = sl.y + sl.height - fillH - sl.width/2
            love.graphics.setColor(sl.thumbColor)
            love.graphics.circle("fill", sl.x + sl.width/2, thumbY + sl.width/2, sl.width/2)
        end
        if sl.showValue then
            love.graphics.setColor(1,1,1)
            love.graphics.print(string.format("%.0f", sl.value), sl.x + sl.width + 10, sl.y + sl.height/2 - 8)
        end
    end

    self.setEnabled = function(sl, en) sl.enabled = en; if not en then sl.dragging = false end end
    self.setPosition = function(sl, nx, ny) sl.x = nx or sl.x; sl.y = ny or sl.y end
    self.getPosition = function(sl) return sl.x, sl.y end
    --[[
    Создатель библиотеки - MrArtem.
    Если вам продали библиотеку не от имени MrArtem'а
    или пытались выдать себя за MrArtem'а
    то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
    Ведь продавец этой библиотеки мог добавить вредоносный файл.
    ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
    на проверенных источниках.
    --]]
    return self
end

return Slider