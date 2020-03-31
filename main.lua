
Camera = require 'camera'
camera = Camera()
sim = require 'sim'

ssx, ssy = love.graphics.getDimensions()

love.filesystem.setIdentity(love.window.getTitle())
math.randomseed(os.time())
love.math.setRandomSeed(os.time())

love.graphics.setDefaultFilter('nearest', 'nearest')
love.graphics.setLineStyle('rough')

gfx = {}
canvases = {}
shaders = {}

fonts = {
    f24 = love.graphics.newFont(24),
    f32 = love.graphics.newFont(32)
}

function love.load()
    sim.load()

    limitFPS = false
    doSim = true
    simFPS = 30
    simTimer = 1 / simFPS
    stepNum = 0
end

function love.mousepressed(x, y, btn, isTouch, presses)
    sim.mousepressed(x, y, btn)
end

function love.keypressed(k, scancode, isRepeat)
    if k == 'escape' then
        love.event.quit()
    elseif k == 'r' then
        sim.initializeX()
        stepNum = 0
    elseif k == 'space' then
        doSim = not doSim
    elseif k == 'right' then
        sim.step()
    end
end

function love.update(dt)
    sim.mouseUpdate(dt)
    if doSim then
        simTimer = simTimer - dt
        if not limitFPS or simTimer < 0 then
            simTimer = simTimer + 1 / simFPS
            sim.step()
        end
    end

    love.window.setTitle('Neural CA (' .. love.timer.getFPS() .. ' FPS)')
end

function love.draw()
    love.graphics.clear(0.8, 0.8, 0.8)
    sim.draw()
end
