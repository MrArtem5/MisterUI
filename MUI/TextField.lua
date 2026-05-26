--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local TextField = {}

function TextField.new(x, y, width, height, placeholder, font, bgColor, borderColor, textColor, placeholderColor, maxLength, passwordChar)
    local self = {}
    self.x = x or 0
    self.y = y or 0
    self.width = width or 200
    self.height = height or 30
    self.placeholder = placeholder or ""
    self.font = font or love.graphics.getFont()
    self.bgColor = bgColor or {0.15, 0.15, 0.2, 1}
    self.borderColor = borderColor or {0.4, 0.4, 0.5, 1}
    self.textColor = textColor or {1, 1, 1, 1}
    self.placeholderColor = placeholderColor or {0.6, 0.6, 0.7, 1}
    self.maxLength = maxLength or 0
    self.passwordChar = passwordChar or nil

    self.text = ""
    self.cursorPos = 1
    self.selectionStart = nil
    self.focused = false
    self.enabled = true
    self.blinkTimer = 0
    self.showCursor = true

    self.setEnabled = function(tf, en) tf.enabled = en; if not en then tf.focused = false end end
    self.setText = function(tf, newText) tf.text = newText or ""; tf.cursorPos = #tf.text + 1; tf.selectionStart = nil end
    self.getText = function(tf) return tf.text end

    local function clampPos(tf, pos) return math.min(math.max(pos, 1), #tf.text + 1) end

    self.update = function(tf, dt)
        if not tf.enabled or not tf.focused then return end
        tf.blinkTimer = tf.blinkTimer + dt
        if tf.blinkTimer >= 0.5 then
            tf.blinkTimer = tf.blinkTimer - 0.5
            tf.showCursor = not tf.showCursor
        end
    end

    self.draw = function(tf)
        love.graphics.setFont(tf.font)
        love.graphics.setColor(tf.bgColor)
        love.graphics.rectangle("fill", tf.x, tf.y, tf.width, tf.height, 3)

        local displayText = tf.text
        if tf.passwordChar and #tf.text > 0 then
            displayText = string.rep(tf.passwordChar, #tf.text)
        end
        if #displayText == 0 and not tf.focused then
            love.graphics.setColor(tf.placeholderColor)
            love.graphics.print(tf.placeholder, tf.x + 5, tf.y + (tf.height - tf.font:getHeight())/2)
        else
            love.graphics.setColor(tf.textColor)
            love.graphics.print(displayText, tf.x + 5, tf.y + (tf.height - tf.font:getHeight())/2)
        end

        if tf.focused and tf.showCursor then
            local cursorX = tf.x + 5 + tf.font:getWidth(displayText:sub(1, tf.cursorPos - 1))
            love.graphics.setColor(1, 1, 1)
            love.graphics.line(cursorX, tf.y + 4, cursorX, tf.y + tf.height - 4)
        end

        love.graphics.setColor(tf.borderColor)
        love.graphics.rectangle("line", tf.x, tf.y, tf.width, tf.height, 3)
    end

    self.textinput = function(tf, text)
        if not tf.enabled or not tf.focused then return end
        if tf.maxLength > 0 and #tf.text >= tf.maxLength then return end
        tf.text = tf.text:sub(1, tf.cursorPos - 1) .. text .. tf.text:sub(tf.cursorPos)
        tf.cursorPos = tf.cursorPos + #text
        tf.selectionStart = nil
    end

    self.keypressed = function(tf, key, scancode, isrepeat)
        if not tf.enabled or not tf.focused then return false end
        if key == "backspace" then
            if tf.cursorPos > 1 then
                tf.text = tf.text:sub(1, tf.cursorPos - 2) .. tf.text:sub(tf.cursorPos)
                tf.cursorPos = tf.cursorPos - 1
            end
        elseif key == "delete" then
            if tf.cursorPos <= #tf.text then
                tf.text = tf.text:sub(1, tf.cursorPos - 1) .. tf.text:sub(tf.cursorPos + 1)
            end
        elseif key == "left" then
            tf.cursorPos = math.max(1, tf.cursorPos - 1)
        elseif key == "right" then
            tf.cursorPos = math.min(#tf.text + 1, tf.cursorPos + 1)
        elseif key == "home" then
            tf.cursorPos = 1
        elseif key == "end" then
            tf.cursorPos = #tf.text + 1
        elseif key == "c" and love.keyboard.isDown("lctrl") then
            love.system.setClipboardText(tf.text)
        elseif key == "v" and love.keyboard.isDown("lctrl") then
            --[[
            Создатель библиотеки - MrArtem.
            Если вам продали библиотеку не от имени MrArtem'а
            или пытались выдать себя за MrArtem'а
            то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
            Ведь продавец этой библиотеки мог добавить вредоносный файл.
            ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
            на проверенных источниках.
            --]]
            local clip = love.system.getClipboardText()
            if clip then
                if tf.maxLength > 0 then
                    clip = clip:sub(1, tf.maxLength - #tf.text)
                end
                tf.text = tf.text:sub(1, tf.cursorPos - 1) .. clip .. tf.text:sub(tf.cursorPos)
                tf.cursorPos = tf.cursorPos + #clip
            end
        elseif key == "x" and love.keyboard.isDown("lctrl") then
            love.system.setClipboardText(tf.text)
            tf.text = ""
            tf.cursorPos = 1
        end
        tf.blinkTimer = 0
        tf.showCursor = true
        return true
    end

    self.mousepressed = function(tf, mx, my, button)
        if button == 1 and mx >= tf.x and mx <= tf.x + tf.width and my >= tf.y and my <= tf.y + tf.height then
            tf.focused = true
            love.graphics.setFont(tf.font)
            local textBefore = tf.text
            if tf.passwordChar then textBefore = string.rep(tf.passwordChar, #tf.text) end
            local totalWidth = 0
            for i = 1, #textBefore + 1 do
                local w = tf.font:getWidth(textBefore:sub(1, i-1))
                if mx <= tf.x + 5 + w then
                    tf.cursorPos = i
                    break
                end
            end
            tf.blinkTimer = 0
            tf.showCursor = true
            return true
        else
            tf.focused = false
        end
        return false
    end

    return self
end

return TextField