--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local ThemeManager = {}

function ThemeManager.new()
    local self = {}
    self.themes = {}
    self.active = nil

    self.addTheme = function(tm, name, theme)
        tm.themes[name] = theme
    end

    self.setTheme = function(tm, name)
        if tm.themes[name] then
            tm.active = tm.themes[name]
        end
    end

    self.getColor = function(tm, key)
        return tm.active and tm.active.colors[key] or {1,1,1}
    end

    self.getFont = function(tm, key)
        return tm.active and tm.active.fonts[key] or love.graphics.getFont()
    end

    self.defaultTheme = {
        colors = {
            button = {0.3, 0.5, 0.8},
            buttonHover = {0.4, 0.6, 0.9},
            buttonPress = {0.2, 0.4, 0.7},
            text = {1,1,1},
            window = {0.2, 0.2, 0.25, 0.95},
            panel = {0.15, 0.15, 0.2, 0.9}
        },
        fonts = {
            default = love.graphics.getFont()
        }
    }
    self:addTheme("default", self.defaultTheme)
    self:setTheme("default")
    return self
end

return ThemeManager





















































--[[
Создатель библиотеки - MrArtem.
Если вам продали библиотеку не от имени MrArtem'а
или пытались выдать себя за MrArtem'а
то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
Ведь продавец этой библиотеки мог добавить вредоносный файл.
ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
на проверенных источниках.
--]]