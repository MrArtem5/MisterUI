--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local Tooltip = {}

function Tooltip.new(text, font, bgColor, textColor, delay)
    local self = {}
    self.text = text or ""
    self.font = font or love.graphics.getFont()
    self.bgColor = bgColor or {0.1, 0.1, 0.15, 0.9}
    self.textColor = textColor or {1,1,1}
    self.delay = delay or 0.5
    self.owner = nil
    self.visible = false
    self.timer = 0
    self.x, self.y = 0, 0

    self.setOwner = function(t, owner) t.owner = owner end

    self.update = function(t, dt)
        if not t.owner then return end
        local mx, my = love.mouse.getPosition()
        local over = false
        if t.owner.isHovered ~= nil then
            over = t.owner.isHovered
        elseif t.owner.update then
            local old = t.owner.update
            t.owner.update = function(...) end
            t.owner:update(dt)
            over = t.owner.isHovered
            t.owner.update = old
        end
        if over then
            t.timer = t.timer + dt
            if t.timer >= t.delay and not t.visible then
                t.visible = true
                t.x = mx + 15
                t.y = my + 15
            elseif t.visible then
                t.x = mx + 15
                t.y = my + 15
            end
        else
            t.timer = 0
            t.visible = false
        end
    end

    self.draw = function(t)
        if not t.visible then return end
        love.graphics.setFont(t.font)
        local tw = t.font:getWidth(t.text)
        local th = t.font:getHeight()
        love.graphics.setColor(t.bgColor)
        love.graphics.rectangle("fill", t.x, t.y, tw + 8, th + 6, 4)
        love.graphics.setColor(t.textColor)
        love.graphics.print(t.text, t.x + 4, t.y + 3)
    end

    return self
end

return Tooltip





































--[[
Создатель библиотеки - MrArtem.
Если вам продали библиотеку не от имени MrArtem'а
или пытались выдать себя за MrArtem'а
то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
Ведь продавец этой библиотеки мог добавить вредоносный файл.
ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
на проверенных источниках.
--]]