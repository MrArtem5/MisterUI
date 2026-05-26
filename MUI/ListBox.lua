--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local ListBox = {}

function ListBox.new(x, y, width, height, items, bgColor, itemColor, selectedColor, textColor, itemHeight)
    local self = {}
    self.x = x or 0
    self.y = y or 0
    self.width = width or 200
    self.height = height or 150
    self.items = items or {}
    self.bgColor = bgColor or {0.15, 0.15, 0.2}
    self.itemColor = itemColor or {0.2, 0.2, 0.25}
    self.selectedColor = selectedColor or {0.3, 0.5, 0.8}
    self.textColor = textColor or {1,1,1}
    self.itemHeight = itemHeight or 25
    self.selectedIndex = nil
    self.callback = nil

    self.scrollOffset = 0
    self.maxScroll = math.max(0, #self.items * self.itemHeight - self.height)

    self.addItem = function(lb, item)
        table.insert(lb.items, item)
        lb.maxScroll = math.max(0, #lb.items * lb.itemHeight - lb.height)
    end

    self.removeItem = function(lb, index)
        table.remove(lb.items, index)
        if lb.selectedIndex == index then lb.selectedIndex = nil end
        lb.maxScroll = math.max(0, #lb.items * lb.itemHeight - lb.height)
        if lb.scrollOffset > lb.maxScroll then lb.scrollOffset = lb.maxScroll end
    end

    self.clear = function(lb) lb.items = {}; lb.selectedIndex = nil; lb.scrollOffset = 0; lb.maxScroll = 0 end

    self.setCallback = function(lb, cb) lb.callback = cb end

    self.update = function(lb)
        local mx, my = love.mouse.getPosition()
        if mx >= lb.x and mx <= lb.x + lb.width and my >= lb.y and my <= lb.y + lb.height then
            local wheel = love.mouse.getWheelDelta()
            if wheel ~= 0 then
                lb.scrollOffset = math.min(math.max(lb.scrollOffset - wheel * 30, 0), lb.maxScroll)
                love.mouse.setWheelDelta(0)
            end
            if love.mouse.isDown(1) then
                local relY = my - lb.y + lb.scrollOffset
                local index = math.floor(relY / lb.itemHeight) + 1
                if index >= 1 and index <= #lb.items then
                    if lb.selectedIndex ~= index then
                        lb.selectedIndex = index
                        if lb.callback then lb.callback(lb.selectedIndex, lb.items[lb.selectedIndex]) end
                    end
                end
            end
        end
    end

    self.draw = function(lb)
        love.graphics.setColor(lb.bgColor)
        love.graphics.rectangle("fill", lb.x, lb.y, lb.width, lb.height, 4)
        love.graphics.setScissor(lb.x, lb.y, lb.width, lb.height)
        for i, item in ipairs(lb.items) do
            local yPos = lb.y + (i-1)*lb.itemHeight - lb.scrollOffset
            if yPos + lb.itemHeight > lb.y and yPos < lb.y + lb.height then
                if i == lb.selectedIndex then
                    love.graphics.setColor(lb.selectedColor)
                    love.graphics.rectangle("fill", lb.x, yPos, lb.width, lb.itemHeight)
                elseif i % 2 == 0 then
                    love.graphics.setColor(lb.itemColor)
                    love.graphics.rectangle("fill", lb.x, yPos, lb.width, lb.itemHeight)
                end
                love.graphics.setColor(lb.textColor)
                love.graphics.print(item, lb.x + 5, yPos + (lb.itemHeight - love.graphics.getFont():getHeight())/2)
            end
        end
        love.graphics.setScissor()
        love.graphics.setColor(lb.bgColor)
        love.graphics.rectangle("line", lb.x, lb.y, lb.width, lb.height, 4)
    end

    self.setPosition = function(lb, nx, ny) lb.x = nx or lb.x; lb.y = ny or lb.y end
    return self
end

return ListBox












--[[
Создатель библиотеки - MrArtem.
Если вам продали библиотеку не от имени MrArtem'а
или пытались выдать себя за MrArtem'а
то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
Ведь продавец этой библиотеки мог добавить вредоносный файл.
ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
на проверенных источниках.
--]]