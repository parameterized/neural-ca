
Camera = require 'camera'
camera = Camera()

ssx, ssy = love.graphics.getDimensions()

love.filesystem.setIdentity(love.window.getTitle())
math.randomseed(os.time())
love.math.setRandomSeed(os.time())

love.graphics.setDefaultFilter('nearest', 'nearest')

gfx = {
    mock = love.graphics.newImage('gfx/mock.png'),
    think = love.graphics.newImage('gfx/think.png')
}

function nc32(w, h)
    return love.graphics.newCanvas(w, h, { format='rgba32f' })
end

canvases = {
    x = nc32(64 * 4, 64),
    h = nc32(64 * 128 / 4, 64),
    y = nc32(64 * 4, 64),
    dense1 = nc32(16 * 3 + 1, 128 / 4),
    dense1Buffer = nc32(16 * 3 + 1, 128 / 4),
    dense1Gradients = nc32(16 * 3 + 1, 128 / 4),
    dense2 = nc32(128 + 1, 16 / 4),
    dense2Buffer = nc32(128 + 1, 16 / 4),
    dense2Gradients = nc32(128 + 1, 16 / 4),
    target = nc32(64, 64)
}

shaders = {
    h = love.graphics.newShader('shaders/h.glsl'),
    y = love.graphics.newShader('shaders/y.glsl'),
    dense2Gradients = love.graphics.newShader('shaders/dense2Gradients.glsl'),
    dense1Gradients = love.graphics.newShader('shaders/dense1Gradients.glsl'),
    updateWeights = love.graphics.newShader('shaders/updateWeights.glsl')
}

fonts = {
    f24 = love.graphics.newFont(24),
    f32 = love.graphics.newFont(32)
}

function kaiming(n)
    return love.math.randomNormal() * math.sqrt(2) / math.sqrt(n)
end

function initializeX()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setCanvas(canvases.x)
    love.graphics.clear()
    love.graphics.draw(gfx.mock)
    love.graphics.setCanvas(canvases.h)
    love.graphics.clear()
    love.graphics.setCanvas()
end

function initializeWeights()
    local dense1 = love.image.newImageData(16 * 3 + 1, 128 / 4, 'rgba32f')
    local dense2 = love.image.newImageData(128 + 1, 16 / 4, 'rgba32f')
    for j=1, 128 / 4 do
        for i=1, 16 * 3 do
            local r = kaiming(49)
            local g = kaiming(49)
            local b = kaiming(49)
            local a = kaiming(49)
            dense1:setPixel(i - 1, j - 1, r, g, b, a)
        end
        --dense1:setPixel(16 * 3, j - 1, 0, 0, 0, 0) -- bias
        --dense1:setPixel(16 * 3, j - 1, 0.5, 0.5, 0.5, 0.5)
    end
    for j=1, 16 / 4 do
        for i=1, 128 do
            local r = kaiming(129)
            local g = kaiming(129)
            local b = kaiming(129)
            local a = kaiming(129)
            dense2:setPixel(i - 1, j - 1, r, g, b, a)
        end
        --dense2:setPixel(128, j - 1, 0.5, 0.5, 0.5, 0.5)
    end
    dense1 = love.graphics.newImage(dense1)
    love.graphics.setCanvas(canvases.dense1)
    love.graphics.clear()
    love.graphics.draw(dense1)
    dense2 = love.graphics.newImage(dense2)
    love.graphics.setCanvas(canvases.dense2)
    love.graphics.clear()
    love.graphics.draw(dense2)
    shaders.h:send('dense1', canvases.dense1)
    shaders.y:send('dense2', canvases.dense2)

    love.graphics.setCanvas()
end

function love.load()
    initializeX()
    initializeWeights()

    shaders.updateWeights:send('alpha', 0.01)

    limitFPS = true
    doSim = true
    simFPS = 30
    simTimer = 1 / simFPS
    train = false

    simDrawQuad = love.graphics.newQuad(0, 0, 64, 64, 64 * 4, 64)
end

function love.update(dt)
    if doSim then
        simTimer = simTimer - dt
        if not limitFPS or simTimer < 0 then
            simTimer = simTimer + 1 / simFPS
            simStep()
        end
    end

    love.window.setTitle('Neural CA (' .. love.timer.getFPS() .. ' FPS)')
end

function love.keypressed(k, scancode, isrepeat)
    if k == 'escape' then
        love.event.quit()
    elseif k == 'r' then
        if love.keyboard.isDown('lshift') or love.keyboard.isDown('rshift') then
            initializeWeights()
        end
        initializeX()
    elseif k == 'space' then
        doSim = not doSim
    elseif k == 'right' then
        simStep()
    elseif k == 't' then
        train = not train
    end
end

function simStep()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setBlendMode('replace', 'premultiplied')

    -- * forward *
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


    if train then
        -- * backward *
        -- get dense2 gradent
        love.graphics.setCanvas(canvases.dense2Gradients)
        love.graphics.setShader()
        love.graphics.clear()
        love.graphics.setShader(shaders.dense2Gradients)
        shaders.dense2Gradients:send('target', canvases.target)
        shaders.dense2Gradients:send('y', canvases.y)
        shaders.dense2Gradients:send('dense2', canvases.dense2)
        shaders.dense2Gradients:send('h', canvases.h)
        love.graphics.rectangle('fill', 0, 0, canvases.dense2Gradients:getDimensions())

        -- todo: rename h to z1

        -- get dense1 gradients
        love.graphics.setCanvas(canvases.dense1Gradients)
        love.graphics.setShader()
        love.graphics.clear()
        love.graphics.setShader(shaders.dense1Gradients)
        shaders.dense1Gradients:send('dense2Gradients', canvases.dense2Gradients)
        shaders.dense1Gradients:send('h', canvases.h)
        shaders.dense1Gradients:send('dense1', canvases.dense1)
        shaders.dense1Gradients:send('x', canvases.x)
        love.graphics.rectangle('fill', 0, 0, canvases.dense1Gradients:getDimensions())


        -- * update *
        -- set buffers
        love.graphics.setCanvas(canvases.dense1Buffer)
        love.graphics.setShader()
        love.graphics.clear()
        love.graphics.draw(canvases.dense1)
        love.graphics.setCanvas(canvases.dense2Buffer)
        love.graphics.clear()
        love.graphics.draw(canvases.dense2)

        -- update dense1
        love.graphics.setCanvas(canvases.dense1)
        love.graphics.setShader()
        --love.graphics.clear()
        love.graphics.setShader(shaders.updateWeights)
        shaders.updateWeights:send('weights', canvases.dense1Buffer)
        shaders.updateWeights:send('gradients', canvases.dense1Gradients)
        --love.graphics.rectangle('fill', 0, 0, canvases.dense1:getDimensions())
        shaders.h:send('dense1', canvases.dense1)

        -- update dense2
        love.graphics.setCanvas(canvases.dense2)
        love.graphics.setShader()
        love.graphics.clear()
        love.graphics.setShader(shaders.updateWeights)
        shaders.updateWeights:send('weights', canvases.dense2Buffer)
        shaders.updateWeights:send('gradients', canvases.dense2Gradients)
        love.graphics.rectangle('fill', 0, 0, canvases.dense2:getDimensions())
        shaders.y:send('dense2', canvases.dense2)
    end


    -- set x to y
    love.graphics.setCanvas(canvases.x)
    love.graphics.setShader()
    love.graphics.clear()
    love.graphics.draw(canvases.y)


    love.graphics.setCanvas()
    love.graphics.setBlendMode('alpha', 'alphamultiply')
end

function love.draw()
    love.graphics.clear(0.8, 0.8, 0.8)

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(canvases.x, simDrawQuad, ssx/2, ssy/2, 0, 8, 8, 32, 32)
    love.graphics.draw(canvases.h, 0, 0, 0, 0.5, 0.5)
    love.graphics.draw(canvases.x, 0, 32)

    if train then
        love.graphics.setColor(0.6, 0.7, 0.9)
        love.graphics.rectangle('fill', ssx - 140, 20, 120, 40)
        love.graphics.setColor(0, 0, 0)
        local text = 'Training'
        local font = fonts.f24
        love.graphics.setFont(font)
        love.graphics.print(text, ssx - 80 - font:getWidth(text) / 2, 40 - font:getHeight() / 2)
    end
end
