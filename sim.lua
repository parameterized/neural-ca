
-- doesn't work correctly yet
local sim = {}

local function nc32(w, h)
    return love.graphics.newCanvas(w, h, { format='rgba32f' })
end

sim.load = function()
    canvases.x = nc32(64 * 4, 64)
    canvases.h = nc32(64 * 128 / 4, 64)
    canvases.y = nc32(64 * 4, 64)

    shaders.h = love.graphics.newShader('shaders/h.glsl')
    shaders.y = love.graphics.newShader('shaders/y.glsl')

    sim.quad = love.graphics.newQuad(0, 0, 64, 64, 64 * 4, 64)

    sim.initializeX()
    sim.loadWeights()
end

sim.initializeX = function()
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

sim.loadWeights = function()
    local weights = dofile('data/weights.lua')
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

sim.step = function()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setBlendMode('replace', 'premultiplied')

    -- get h
    love.graphics.setCanvas(canvases.h)
    love.graphics.clear()
    love.graphics.setShader(shaders.h)
    shaders.h:send('xin', canvases.x)
    love.graphics.rectangle('fill', 0, 0, canvases.h:getDimensions())

    -- get y
    love.graphics.setCanvas(canvases.y)
    love.graphics.setShader() -- todo: test if clear uses shader, remove if it doesn't
    love.graphics.clear() -- todo: test if replace makes clear redundant
    love.graphics.setShader(shaders.y)
    shaders.y:send('xin', canvases.x)
    shaders.y:send('h', canvases.h)
    love.graphics.rectangle('fill', 0, 0, canvases.y:getDimensions())

    -- set x to y
    love.graphics.setCanvas(canvases.x)
    love.graphics.setShader()
    love.graphics.clear()
    love.graphics.draw(canvases.y)

    love.graphics.setCanvas()
    love.graphics.setBlendMode('alpha', 'alphamultiply')

    stepNum = stepNum + 1
end

sim.draw = function()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(canvases.x, sim.quad, ssx/2, ssy/2, 0, 8, 8, 32, 32)
    love.graphics.draw(canvases.h, 0, 0, 0, 0.5, 0.5)
    love.graphics.draw(canvases.x, 0, 32)
end

return sim
