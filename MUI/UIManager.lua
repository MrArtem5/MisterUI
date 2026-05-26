--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local UIManager = {}

function UIManager.new()
    local self = {}
    self.elements = {}
    self.focusedElement = nil

    self.add = function(ui, elem, z)
        table.insert(ui.elements, {elem = elem, z = z or 0})
        table.sort(ui.elements, function(a,b) return a.z < b.z end)
    end

    self.remove = function(ui, elem)
        for i, e in ipairs(ui.elements) do
            if e.elem == elem then
                table.remove(ui.elements, i)
                if ui.focusedElement == elem then ui.focusedElement = nil end
                break
            end
        end
    end

    self.update = function(ui, dt)
        for _, e in ipairs(ui.elements) do
            if e.elem.update then e.elem:update(dt) end
        end
    end

    self.draw = function(ui)
        for _, e in ipairs(ui.elements) do
            if e.elem.draw then e.elem:draw() end
        end
    end

    self.mousepressed = function(ui, mx, my, button)
        for i = #ui.elements, 1, -1 do
            local e = ui.elements[i].elem
            if e.mousepressed and e:mousepressed(mx, my, button) then
                return true
            end
        end
        return false
    end

    self.textinput = function(ui, text)
        if ui.focusedElement and ui.focusedElement.textinput then
            ui.focusedElement:textinput(text)
        end
    end

    self.keypressed = function(ui, key, scancode, isrepeat)
        if ui.focusedElement and ui.focusedElement.keypressed then
            return ui.focusedElement:keypressed(key, scancode, isrepeat)
        end
        return false
    end

    return self
end

return UIManager




































--[[
Создатель библиотеки - MrArtem.
Если вам продали библиотеку не от имени MrArtem'а
или пытались выдать себя за MrArtem'а
то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
Ведь продавец этой библиотеки мог добавить вредоносный файл.
ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
на проверенных источниках.
--]]