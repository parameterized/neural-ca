
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
    doSim = true
end

function love.mousepressed(x, y, btn, isTouch, presses)
    sim.mousepressed(x, y, btn)
end

function love.mousemoved(x, y, dx, dy, isTouch)
    sim.mousemoved(x, y, dx, dy)
end

function love.keypressed(k, scancode, isRepeat)
    if k == 'escape' then
        love.event.quit()
    elseif k == 'r' then
        sim.initializeX()
    elseif k == 'space' then
        doSim = not doSim
    elseif k == 'right' then
        sim.step()
    elseif k == 'l' then
        sim.maxStepsPerSec = -sim.maxStepsPerSec
        sim.stepTimer = 0
    end
end

function love.update(dt)
    sim.mouseUpdate(dt)
    if doSim then
        sim.update(dt)
    end
end

function love.draw()
    love.graphics.clear(0.8, 0.8, 0.8)
    sim.draw()
end
