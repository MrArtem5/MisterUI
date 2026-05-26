--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local ScrollPanel = {}

function ScrollPanel.new(x, y, width, height, contentHeight, color, borderColor, borderRadius, scrollBarColor)
    local self = {}

    self.x = x or 0
    self.y = y or 0
    self.width = width or 350
    self.height = height or 350
    self.contentHeight = contentHeight or 400
    self.color = color or {0.3, 0.3, 0.3, 0.8}
    self.borderColor = borderColor or {0.2, 0.2, 0.2, 0.9}
    self.borderRadius = borderRadius or 0
    self.scrollBarColor = scrollBarColor or {0.7, 0.7, 0.7, 0.8}
    self.scrollBarWidth = 8

    self.scrollOffset = 0
    self.maxScroll = math.max(0, self.contentHeight - self.height)

    self.children = {}
    self.visible = true
    self.clipChildren = true

    self.smoothScroll = false
    self.targetScroll = 0
    function self.setContentHeight(sp, newHeight)
        sp.contentHeight = newHeight
        sp.maxScroll = math.max(0, sp.contentHeight - sp.height)
        if sp.scrollOffset > sp.maxScroll then
            sp.scrollOffset = sp.maxScroll
            sp.targetScroll = sp.scrollOffset
        end
    end

    function self.getContentHeight(sp)
        return sp.contentHeight
    end

    function self.setScrollOffset(sp, offset)
        sp.scrollOffset = math.min(math.max(offset, 0), sp.maxScroll)
        sp.targetScroll = sp.scrollOffset
    end

    function self.getScrollOffset(sp)
        return sp.scrollOffset
    end

    function self.scrollBy(sp, delta)
        sp:setScrollOffset(sp.scrollOffset + delta)
    end

    function self.addChild(sp, child)
        if child then
            table.insert(sp.children, child)
        end
    end

    function self.removeChild(sp, child)
        for i, c in ipairs(sp.children) do
            if c == child then
                table.remove(sp.children, i)
                break
            end
        end
    end

    function self.clearChildren(sp)
        sp.children = {}
    end

    function self.update(sp, dt)
        if not sp.visible then return end

        local mx, my = love.mouse.getPosition()
        local overPanel = mx >= sp.x and mx <= sp.x + sp.width and
                          my >= sp.y and my <= sp.y + sp.height

        if overPanel then
            local wheelY = love.mouse.getWheelDelta()
            if wheelY ~= 0 then
                local step = 30 * wheelY
                sp:scrollBy(-step)
                love.mouse.setWheelDelta(0)
            end
        end

        if sp.smoothScroll then
            sp.scrollOffset = sp.scrollOffset + (sp.targetScroll - sp.scrollOffset) * math.min(10 * dt, 1)
        end

        for _, child in ipairs(sp.children) do
            if child.update then
                child:update(dt)
            end
        end
    end

    --[[
    Создатель библиотеки - MrArtem.
    Если вам продали библиотеку не от имени MrArtem'а
    или пытались выдать себя за MrArtem'а
    то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
    Ведь продавец этой библиотеки мог добавить вредоносный файл.
    ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
    на проверенных источниках.
    --]]
    function self.draw(sp)
        if not sp.visible then return end

        love.graphics.setScissor(sp.x, sp.y, sp.width, sp.height)

        love.graphics.setColor(sp.color)
        if sp.borderRadius > 0 then
            love.graphics.rectangle("fill", sp.x, sp.y, sp.width, sp.height, sp.borderRadius)
        else
            love.graphics.rectangle("fill", sp.x, sp.y, sp.width, sp.height)
        end

        love.graphics.push()
        love.graphics.translate(0, -sp.scrollOffset)

        for _, child in ipairs(sp.children) do
            if child.draw then
                child:draw()
            end
        end

        love.graphics.pop()

        if sp.maxScroll > 0 then
            local barHeight = math.max(20, (sp.height / sp.contentHeight) * sp.height)
            local barY = sp.y + (sp.scrollOffset / sp.maxScroll) * (sp.height - barHeight)
            love.graphics.setColor(sp.scrollbarColor)
            love.graphics.rectangle("fill", sp.x + sp.width - sp.scrollbarWidth, barY, sp.scrollbarWidth, barHeight, 4)
        end

        love.graphics.setColor(sp.borderColor)
        if sp.borderRadius > 0 then
            love.graphics.rectangle("line", sp.x, sp.y, sp.width, sp.height, sp.borderRadius)
        else
            love.graphics.rectangle("line", sp.x, sp.y, sp.width, sp.height)
        end

        love.graphics.setScissor()
    end

    function self.setPosition(sp, nx, ny)
        local dx = nx - sp.x
        local dy = ny - sp.y
        sp.x = nx
        sp.y = ny
        for _, child in ipairs(sp.children) do
            if child.setPosition then
                child:setPosition(child.x + dx, child.y + dy)
            end
        end
    end

    function self.getPosition(sp)
        return sp.x, sp.y
    end

    function self.setSize(sp, newWidth, newHeight)
        sp.width = newWidth or sp.width
        sp.height = newHeight or sp.height
        sp.maxScroll = math.max(0, sp.contentHeight - sp.height)
        if sp.scrollOffset > sp.maxScroll then
            sp.scrollOffset = sp.maxScroll
        end
    end

    function self.getSize(sp)
        return sp.width, sp.height
    end

    function self.setVisible(sp, visible)
        sp.visible = visible
    end

    function self.isVisible(sp)
        return sp.visible
    end

    return self
end

return ScrollPanel