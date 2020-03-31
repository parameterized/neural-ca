
-- doesn't work correctly yet
local sim = {}

local function nc32(w, h)
    return love.graphics.newCanvas(w, h, { format='rgba32f' })
end

function sim.load()
    canvases.x = nc32(64 * 4, 64)
    canvases.h = nc32(64 * 128 / 4, 64)
    canvases.y = nc32(64 * 4, 64)
    canvases.edit = nc32(64, 64)

    shaders.h = love.graphics.newShader('shaders/h.glsl')
    shaders.y = love.graphics.newShader('shaders/y.glsl')
    shaders.edit = love.graphics.newShader('shaders/edit.glsl')

    sim.xQuad = love.graphics.newQuad(0, 0, 64, 64, 64 * 4, 64)

    sim.viewport = { w=64 * 8, h=64 * 8 }
    sim.viewport.x = math.floor(ssx / 2 - sim.viewport.w / 2)
    sim.viewport.y = math.floor(ssy / 2 - sim.viewport.h / 2)

    sim.initializeX()
    sim.loadWeights()
end

function sim.initializeX()
    love.graphics.setCanvas(canvases.x)
    love.graphics.clear()
    -- rgb 0, alpha & all other channels 1
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('fill', 32, 32, 1, 1)
    love.graphics.setColor(1, 1, 1)
    for i=1, 3 do
        love.graphics.rectangle('fill', 32 + i * 64, 32, 1, 1)
    end
    love.graphics.setCanvas(canvases.h)
    love.graphics.clear()
    love.graphics.setCanvas()
end

function sim.loadWeights()
    local weights = dofile('data/persist_4k.lua')
    local dense1 = love.image.newImageData(16 * 3 + 1, 128 / 4, 'rgba32f')
    local dense2 = love.image.newImageData(128 + 1, 16 / 4, 'rgba32f')
    for j=1, 128 / 4 do
        local j0 = (j - 1) * 4
        local w = weights.d1_kernel
        for i=1, 16 * 3 do
            dense1:setPixel(i - 1, j - 1, w[i][j0 + 1], w[i][j0 + 2], w[i][j0 + 3], w[i][j0 + 4])
        end
        local b = weights.d1_bias
        dense1:setPixel(16 * 3, j - 1, b[j0 + 1], b[j0 + 2], b[j0 + 3], b[j0 + 4])
    end
    for j=1, 16 / 4 do
        local j0 = (j - 1) * 4
        local w = weights.d2_kernel
        for i=1, 128 do
            dense2:setPixel(i - 1, j - 1, w[i][j0 + 1], w[i][j0 + 2], w[i][j0 + 3], w[i][j0 + 4])
        end
        local b = weights.d2_bias
        dense2:setPixel(128, j - 1, b[j0 + 1], b[j0 + 2], b[j0 + 3], b[j0 + 4])
    end
    shaders.h:send('dense1', love.graphics.newImage(dense1))
    shaders.y:send('dense2', love.graphics.newImage(dense2))
end

function sim.mouseToCell(x, y)
    local v = sim.viewport
    local cx = math.floor((x - v.x) / v.w * 64)
    local cy = math.floor((y - v.y) / v.h * 64)
    return cx, cy
end

function sim.mousepressed(x, y, btn)
    if btn == 1 and love.keyboard.isScancodeDown('lshift') then
        local cx, cy = sim.mouseToCell(x, y)
        local _canvas = love.graphics.getCanvas()
        local _shader = love.graphics.getShader()
        love.graphics.setBlendMode('replace', 'premultiplied')

        -- get edit
        love.graphics.setCanvas(canvases.edit)
        love.graphics.setShader()
        love.graphics.clear()
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle('fill', cx, cy, 1, 1)

        -- get y
        love.graphics.setCanvas(canvases.y)
        love.graphics.setShader(shaders.edit)
        shaders.edit:send('xin', canvases.x)
        shaders.edit:send('edit', canvases.edit)
        love.graphics.rectangle('fill', 0, 0, canvases.x:getDimensions())

        -- set x to y
        love.graphics.setShader()
        love.graphics.setCanvas(canvases.x)
        love.graphics.draw(canvases.y)

        love.graphics.setBlendMode('alpha', 'alphamultiply')
        love.graphics.setShader(_shader)
        love.graphics.setCanvas(_canvas)
    end
end

function sim.mouseUpdate(dt)
    if love.mouse.isDown(1) and not love.keyboard.isScancodeDown('lshift') then
        local cellX, cellY = sim.mouseToCell(love.mouse.getPosition())
        local _canvas = love.graphics.getCanvas()
        local _shader = love.graphics.getShader()
        love.graphics.setBlendMode('replace', 'premultiplied')

        -- get edit
        love.graphics.setCanvas(canvases.edit)
        love.graphics.setShader()
        love.graphics.clear()
        love.graphics.setColor(0, 0, 0)
        -- loop edit circle
        for i=0, 1 do
            local circleX = cellX + i * 64 * (cellX < 32 and 1 or -1)
            for j=0, 1 do
                local circleY = cellY + j * 64 * (cellY < 32 and 1 or -1)
                love.graphics.circle('fill', circleX, circleY, 10)
            end
        end

        -- get y
        love.graphics.setCanvas(canvases.y)
        love.graphics.setShader(shaders.edit)
        shaders.edit:send('xin', canvases.x)
        shaders.edit:send('edit', canvases.edit)
        love.graphics.rectangle('fill', 0, 0, canvases.x:getDimensions())

        -- set x to y
        love.graphics.setShader()
        love.graphics.setCanvas(canvases.x)
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(canvases.y)

        love.graphics.setBlendMode('alpha', 'alphamultiply')
        love.graphics.setShader(_shader)
        love.graphics.setCanvas(_canvas)
    end
end

function sim.step()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setBlendMode('replace', 'premultiplied')

    -- get h
    love.graphics.setCanvas(canvases.h)
    love.graphics.setShader(shaders.h)
    shaders.h:send('xin', canvases.x)
    love.graphics.rectangle('fill', 0, 0, canvases.h:getDimensions())

    -- get y
    love.graphics.setCanvas(canvases.y)
    love.graphics.setShader(shaders.y)
    shaders.y:send('xin', canvases.x)
    shaders.y:send('h', canvases.h)
    shaders.y:send('randOffset', { love.math.random() * 1000, love.math.random() * 1000 })
    love.graphics.rectangle('fill', 0, 0, canvases.y:getDimensions())

    -- set x to y
    love.graphics.setCanvas(canvases.x)
    love.graphics.setShader()
    love.graphics.draw(canvases.y)

    love.graphics.setCanvas()
    love.graphics.setBlendMode('alpha', 'alphamultiply')

    stepNum = stepNum + 1
end

function sim.draw()
    love.graphics.setColor(0.1, 0.1, 0.1)
    local v = sim.viewport
    love.graphics.rectangle('fill', v.x - 4, v.y - 4, v.w + 8, v.h + 8)
    love.graphics.setColor(0.9, 0.9, 0.9)
    love.graphics.rectangle('fill', v.x, v.y, v.w, v.h)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(canvases.x, sim.xQuad, ssx / 2, ssy / 2, 0, 8, 8, 32, 32)
    love.graphics.draw(canvases.h, 0, 0, 0, 0.5, 0.5)
    love.graphics.draw(canvases.x, 0, 32)
end

return sim
