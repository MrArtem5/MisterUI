--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local ProgressBar = {}

function ProgressBar.new(x, y, width, height, value, max, bgColor, fillColor, textColor, showPercent)
    local self = {}
    self.x = x or 0
    self.y = y or 0
    self.width = width or 200
    self.height = height or 20
    self.value = value or 0
    self.max = max or 100
    self.bgColor = bgColor or {0.2, 0.2, 0.3}
    self.fillColor = fillColor or {0.3, 0.8, 0.3}
    self.textColor = textColor or {1,1,1}
    self.showPercent = showPercent or false

    self.setValue = function(pb, v) pb.value = math.min(math.max(v, 0), pb.max) end
    self.getValue = function(pb) return pb.value end
    self.setMax = function(pb, m) pb.max = m end

    self.draw = function(pb)
        love.graphics.setColor(pb.bgColor)
        love.graphics.rectangle("fill", pb.x, pb.y, pb.width, pb.height, 4)
        local fillW = (pb.value / pb.max) * pb.width
        love.graphics.setColor(pb.fillColor)
        love.graphics.rectangle("fill", pb.x, pb.y, fillW, pb.height, 4)
        if pb.showPercent then
            love.graphics.setColor(pb.textColor)
            local percent = math.floor(pb.value / pb.max * 100)
            local text = percent .. "%"
            local tw = love.graphics.getFont():getWidth(text)
            love.graphics.print(text, pb.x + (pb.width - tw)/2, pb.y + (pb.height - love.graphics.getFont():getHeight())/2)
        end
    end

    self.setPosition = function(pb, nx, ny) pb.x = nx or pb.x; pb.y = ny or pb.y end
    return self
end

return ProgressBar


























































--[[
Создатель библиотеки - MrArtem.
Если вам продали библиотеку не от имени MrArtem'а
или пытались выдать себя за MrArtem'а
то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
Ведь продавец этой библиотеки мог добавить вредоносный файл.
ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
на проверенных источниках.
--]]