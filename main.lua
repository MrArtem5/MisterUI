--MrArtem - тест скрипт для MUI, чтобы вы поняли логику библиотеки на версии 0.1.0
local MUI = require("MUI")

local mainPanel
local demoButton
local demoCheckBox
local clickCount = 0

function love.load()
    love.window.setTitle("MUI Demo")
    love.window.maximize()
    
    local font = love.graphics.newFont(24)
    love.graphics.setFont(font)
    
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    
    mainPanel = MUI.Panel.new(
        w/2 - 250, h/2 - 150,
        500, 300,
        {0.1, 0.1, 0.15, 0.95},
        {0.6, 0.3, 0.8, 1},
        10
    )
    
    demoButton = MUI.Button.new(
        mainPanel.x + 150, mainPanel.y + 100,
        200, 50,
        "Нажми меня",
        function()
            clickCount = clickCount + 1
            print("Нажатий: " .. clickCount)
        end,
        {0.3, 0.3, 0.5},
        {0.2, 0.2, 0.4},
        {0.4, 0.4, 0.6},
        {0.6, 0.4, 0.8},
        {1, 1, 1}
    )
    
    demoCheckBox = MUI.CheckBox.new(
        mainPanel.x + 150, mainPanel.y + 180,
        25, "Включить режим",
        false,
        function(checked)
            if checked then
                print("Режим включён")
            else
                print("Режим выключен")
            end
        end,
        {0.3, 0.3, 0.5},
        {0.8, 0.8, 0.8},
        {1, 1, 1},
        {0.6, 0.4, 0.8}
    )
    
    mainPanel:addChild(demoButton)
    mainPanel:addChild(demoCheckBox)
end

function love.update(dt)
    mainPanel:update(dt)
end

function love.draw()
    love.graphics.clear(0.05, 0.05, 0.1)
    mainPanel:draw()
    
    love.graphics.setColor(0.7, 0.7, 0.7)
    love.graphics.print("Нажатий: " .. clickCount, 50, 50)
    love.graphics.print("F11 - полноэкранный режим | ESC - выход", 50, love.graphics.getHeight() - 30)
end

function love.resize(w, h)
    mainPanel:setPosition(w/2 - 250, h/2 - 150)
    demoButton.x = mainPanel.x + 150
    demoButton.y = mainPanel.y + 100
    demoCheckBox.x = mainPanel.x + 150
    demoCheckBox.y = mainPanel.y + 180
end

function love.keypressed(key)
    if key == "f11" then
        local fs = love.window.getFullscreen()
        if not fs then
            love.window.setFullscreen(true, "desktop")
        else
            love.window.setFullscreen(false)
            love.window.maximize()
        end
    elseif key == "escape" then
        love.event.quit()
    end
end
