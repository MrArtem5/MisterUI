-- Демо-игра с использованием библиотеки MUI

local MUI = require("MUI")

function love.load()
    love.window.setTitle("MUI Demo - Догонялка с убийцами")
    love.window.setMode(1024, 768, {resizable=false})
    
    love.graphics.setFont(love.graphics.newFont(18))

    gameRunning = true
    score = 0
    timeSurvived = 0
    playerHealth = 100
    enemySpeed = 120
    
    player = {
        x = 512, y = 384,
        width = 40, height = 40,
        speed = 300
    }
    
    enemies = {}
    for i = 1, 3 do
        table.insert(enemies, {
            x = math.random(100, 924),
            y = math.random(100, 668),
            width = 40, height = 40,
            speed = enemySpeed
        })
    end
    
    
    infoPanel = MUI.Panel.new(10, 10, 300, 120, 
        {0.1, 0.1, 0.2, 0.85}, 
        {0.3, 0.5, 0.8, 0.9}, 8)
    
    healthCircle = MUI.CircularProgress.new(
        50, 45, 35, playerHealth, 100,
        {0.9, 0.2, 0.2}, {0.3, 0.3, 0.4}, true
    )
    
    local canvas = love.graphics.newCanvas(32, 32)
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    love.graphics.setColor(1, 0.8, 0, 1)
    love.graphics.circle("fill", 16, 16, 14)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.circle("fill", 12, 12, 2)
    love.graphics.circle("fill", 20, 12, 2)
    love.graphics.arc("fill", 16, 20, 8, 0, math.pi)
    love.graphics.setCanvas()
    
    playerSprite = MUI.Sprite.new(
        100, 200, 32, 32, canvas, 1, 10, true
    )
    
    controlPanel = MUI.Panel.new(714, 10, 300, 200,
        {0.15, 0.15, 0.25, 0.9},
        {0.5, 0.5, 0.7, 0.9}, 8)
    
    restartButton = MUI.Button.new(
        734, 50, 260, 45, "Новая игра",
        function()
            gameRunning = true
            score = 0
            timeSurvived = 0
            playerHealth = 100
            player.x, player.y = 512, 384
            for _, enemy in ipairs(enemies) do
                enemy.x = math.random(100, 924)
                enemy.y = math.random(100, 668)
            end
            healthCircle:setValue(100)
        end,
        {0.2, 0.6, 0.3}, {0.1, 0.4, 0.2}, {0.3, 0.7, 0.4},
        {0.4, 0.8, 0.5}, {1, 1, 1}
    )
    
    exitButton = MUI.Button.new(
        734, 110, 260, 45, "Выход",
        function() love.event.quit() end,
        {0.7, 0.2, 0.2}, {0.5, 0.1, 0.1}, {0.8, 0.3, 0.3},
        {0.9, 0.4, 0.4}, {1, 1, 1}
    )
    
    controlPanel:addChild(restartButton)
    controlPanel:addChild(exitButton)
    
    showEnemiesCheck = MUI.CheckBox.new(
        734, 175, 20, "Показывать врагов", true,
        function(checked) showEnemies = checked end,
        {0.3, 0.3, 0.5}, {0.5, 0.5, 0.8}, {1, 1, 1}
    )
    controlPanel:addChild(showEnemiesCheck)
    
    local bgLayer1 = love.graphics.newCanvas(1024, 768)
    love.graphics.setCanvas(bgLayer1)
    love.graphics.clear()
    love.graphics.setColor(0.2, 0.2, 0.3, 1)
    for i = 1, 50 do
        love.graphics.circle("fill", math.random(1024), math.random(768), math.random(2, 8))
    end
    love.graphics.setCanvas()
    
    local bgLayer2 = love.graphics.newCanvas(1024, 768)
    love.graphics.setCanvas(bgLayer2)
    love.graphics.clear()
    love.graphics.setColor(0.4, 0.4, 0.5, 0.7)
    for i = 1, 30 do
        love.graphics.rectangle("fill", math.random(1024), math.random(768), math.random(10, 30), math.random(10, 30))
    end
    love.graphics.setCanvas()
    
    parallaxBG = MUI.ParallaxPanel.new(
        0, 0, 1024, 768,
        {
            {bgLayer1, 0.05, 0.05, 0.8},
            {bgLayer2, 0.15, 0.15, 0.6}
        },
        {0.1, 0.1, 0.1, 0}, 0
    )
    
    particleEmitter = MUI.ParticlesEmitter.new()
    
    spawnTimer = 0
end

function love.update(dt)
    if not gameRunning then
        if infoPanel then infoPanel:update(dt) end
        if controlPanel then controlPanel:update(dt) end
        if healthCircle then healthCircle:update(dt) end
        return
    end
    
    timeSurvived = timeSurvived + dt
    score = math.floor(timeSurvived * 10)
    
    local moveX, moveY = 0, 0
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then moveY = -1 end
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then moveY = 1 end
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then moveX = -1 end
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then moveX = 1 end
    
    if moveX ~= 0 or moveY ~= 0 then
        local len = math.sqrt(moveX * moveX + moveY * moveY)
        moveX = moveX / len
        moveY = moveY / len
    end
    
    player.x = player.x + moveX * player.speed * dt
    player.y = player.y + moveY * player.speed * dt
    
    player.x = math.max(10, math.min(1024 - player.width - 10, player.x))
    player.y = math.max(10, math.min(768 - player.height - 10, player.y))
    
    playerSprite:setPosition(player.x, player.y)
    playerSprite:update(dt)
    
    for i, enemy in ipairs(enemies) do
        local dx = player.x - enemy.x
        local dy = player.y - enemy.y
        local dist = math.sqrt(dx * dx + dy * dy)
        
        if dist > 0 then
            enemy.x = enemy.x + (dx / dist) * enemy.speed * dt
            enemy.y = enemy.y + (dy / dist) * enemy.speed * dt
        end
        
        if math.abs(player.x - enemy.x) < player.width and 
           math.abs(player.y - enemy.y) < player.height then
            playerHealth = playerHealth - 50
            healthCircle:setValue(playerHealth)
            
            particleEmitter:emit(player.x + player.width/2, player.y + player.height/2, 20, {
                speedMin = 80, speedMax = 200,
                angleMin = -math.pi/4, angleMax = math.pi/4,
                lifetimeMin = 0.5, lifetimeMax = 1.0,
                sizeStart = 6, sizeEnd = 2,
                colorStart = {0.8, 0.1, 0.1},
                colorEnd = {0.5, 0, 0},
                gravity = 200
            })
            
            if playerHealth <= 0 then
                gameRunning = false
                particleEmitter:emit(player.x + player.width/2, player.y + player.height/2, 50, {
                    speedMin = 100, speedMax = 300,
                    angleMin = 0, angleMax = math.pi*2,
                    lifetimeMin = 0.8, lifetimeMax = 1.5,
                    sizeStart = 8, sizeEnd = 1,
                    colorStart = {0.9, 0.1, 0.1},
                    colorEnd = {0.3, 0, 0},
                    gravity = 100
                })
            end
            
            if dist > 0 then
                enemy.x = enemy.x - (dx / dist) * 80
                enemy.y = enemy.y - (dy / dist) * 80
            end
        end
    end
    
    spawnTimer = spawnTimer + dt
    if spawnTimer > 8 and #enemies < 6 then
        spawnTimer = 0
        table.insert(enemies, {
            x = math.random(100, 924),
            y = math.random(100, 668),
            width = 40, height = 40,
            speed = enemySpeed + math.random(-20, 30)
        })
        enemySpeed = enemySpeed + 5
        for _, enemy in ipairs(enemies) do
            enemy.speed = enemySpeed
        end
    end
    
    infoPanel:update(dt)
    controlPanel:update(dt)
    healthCircle:update(dt)
    parallaxBG:update(dt)
    particleEmitter:update(dt)
    
    showEnemies = showEnemiesCheck:getChecked()
end

function love.draw()
    parallaxBG:draw()
    
    if showEnemies or gameRunning == false then
        for _, enemy in ipairs(enemies) do
            love.graphics.setColor(0.9, 0.2, 0.2)
            love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.width, enemy.height)
            love.graphics.setColor(0.5, 0, 0)
            love.graphics.rectangle("line", enemy.x, enemy.y, enemy.width, enemy.height)
        end
    end
    
    playerSprite:draw()
    
    particleEmitter:draw()
    
    infoPanel:draw()
    
    love.graphics.setFont(love.graphics.newFont(16))
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Здоровье", 20, 20)
    healthCircle:draw()
    
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Время выживания: " .. string.format("%.1f", timeSurvived) .. " сек", 20, 90)
    love.graphics.print("Счёт: " .. score, 20, 120)
    love.graphics.print("Врагов: " .. #enemies, 20, 150)
    
    controlPanel:draw()
    
    if not gameRunning then
        love.graphics.setFont(love.graphics.newFont(48))
        love.graphics.setColor(0.9, 0.2, 0.2, 0.9)
        love.graphics.printf("ИГРА ОКОНЧЕНА!", 0, 300, love.graphics.getWidth(), "center")
        love.graphics.setFont(love.graphics.newFont(24))
        love.graphics.setColor(1, 1, 1, 0.8)
        love.graphics.printf("Ваш счёт: " .. score, 0, 370, love.graphics.getWidth(), "center")
        love.graphics.printf("Нажмите 'Новая игра'", 0, 410, love.graphics.getWidth(), "center")
    end
    
    love.graphics.setFont(love.graphics.newFont(14))
    love.graphics.setColor(0.8, 0.8, 0.8, 0.7)
    love.graphics.print("FPS: " .. love.timer.getFPS(), love.graphics.getWidth() - 80, 10)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "r" and not gameRunning then
        restartButton.callback()
    end
end
