--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local Window = {}

function Window.new(x, y, width, height, title, color, borderColor, titleColor, closeButton, draggable, resizable)
    local self = {}
    self.x = x or 100
    self.y = y or 100
    self.width = width or 300
    self.height = height or 200
    self.title = title or "Window"
    self.color = color or {0.2, 0.2, 0.25, 0.95}
    self.borderColor = borderColor or {0.6, 0.6, 0.7}
    self.titleColor = titleColor or {1,1,1}
    self.closeButton = closeButton or true
    self.draggable = draggable or true
    self.resizable = resizable or false

    self.children = {}
    self.visible = true
    self.modal = false
    self.dragging = false
    self.dragX = 0
    self.dragY = 0

    self.addChild = function(w, child) table.insert(w.children, child) end
    self.removeChild = function(w, child) for i,c in ipairs(w.children) do if c==child then table.remove(w.children,i) break end end end

    self.update = function(w, dt)
        if not w.visible then return end
        if w.dragging then
            if not love.mouse.isDown(1) then
                w.dragging = false
            else
                local mx, my = love.mouse.getPosition()
                w.x = mx - w.dragX
                w.y = my - w.dragY
            end
        end
        for _, child in ipairs(w.children) do
            if child.update then child:update(dt) end
        end
    end

    self.draw = function(w)
        if not w.visible then return end
        love.graphics.setColor(w.color)
        love.graphics.rectangle("fill", w.x, w.y, w.width, w.height, 8)
        love.graphics.setColor(w.titleColor)
        love.graphics.print(w.title, w.x + 10, w.y + 8)
        if w.closeButton then
            love.graphics.setColor(0.8, 0.2, 0.2)
            love.graphics.rectangle("fill", w.x + w.width - 25, w.y + 5, 20, 20, 4)
            love.graphics.setColor(1,1,1)
            love.graphics.print("X", w.x + w.width - 20, w.y + 8)
        end
        love.graphics.setColor(w.borderColor)
        love.graphics.rectangle("line", w.x, w.y, w.width, w.height, 8)

        for _, child in ipairs(w.children) do
            if child.draw then child:draw() end
        end
    end

    self.mousepressed = function(w, mx, my, button)
        if not w.visible or button ~= 1 then return false end
        local inTitle = mx >= w.x and mx <= w.x + w.width and my >= w.y and my <= w.y + 30
        if w.draggable and inTitle then
            w.dragging = true
            w.dragX = mx - w.x
            w.dragY = my - w.y
            return true
        end
        if w.closeButton and mx >= w.x + w.width - 25 and mx <= w.x + w.width - 5 and my >= w.y + 5 and my <= w.y + 25 then
            w.visible = false
            return true
        end
        return false
    end

    self.setPosition = function(w, nx, ny) w.x = nx or w.x; w.y = ny or w.y end
    self.setSize = function(w, nw, nh) w.width = nw or w.width; w.height = nh or w.height end
    self.setVisible = function(w, vis) w.visible = vis end
    self.setModal = function(w, modal) w.modal = modal end

    return self
end

return Window










--[[
Создатель библиотеки - MrArtem.
Если вам продали библиотеку не от имени MrArtem'а
или пытались выдать себя за MrArtem'а
то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
Ведь продавец этой библиотеки мог добавить вредоносный файл.
ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
на проверенных источниках.
--]]