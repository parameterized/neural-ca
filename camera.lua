
local camera = {}
camera.__index = camera

local function new(opts)
	local obj = {
		x=0, y=0, scale=1, rotation=0
	}
	-- screen size x, y
	obj.ssx, obj.ssy = love.graphics.getDimensions()
	opts = opts or {}
	for k, v in pairs(opts) do obj[k] = v end
	local cam = setmetatable(obj, camera)
	return cam
end

local function rotate(x, y, a)
	local s = math.sin(a);
	local c = math.cos(a);
	local x2 = x*c + y*s
	local y2 = y*c - x*s
	return x2, y2
end

function camera:clone()
	return Camera{
		x = self.x, y = self.y,
		scale = self.scale, rotation = self.rotation,
		ssx = self.ssx, ssy = self.ssy
	}
end

function camera:setPosition(x, y)
	self.x, self.y = x, y
end

function camera:getPosition()
	return self.x, self.y
end

function camera:move(dx, dy)
	self.x = self.x + dx
	self.y = self.y + dy
end

-- todo: better name
function camera:scaleBy(x)
	self.scale = self.scale*x
end

function camera:rotate(a)
	self.rotation = self.rotation + a
end

function camera:set()
	love.graphics.push()
	love.graphics.translate(self.ssx/2, self.ssy/2)
	love.graphics.scale(self.scale)
	love.graphics.rotate(self.rotation)
	love.graphics.translate(-self.x, -self.y)
end

function camera:reset()
	love.graphics.pop()
end

function camera:draw(f)
	self:set()
	f()
	self:reset()
end

function camera:screen2world(x, y)
	x = x - self.ssx/2
	y = y - self.ssy/2
	x = x / self.scale
	y = y / self.scale
	x, y = rotate(x, y, self.rotation)
	x = x + self.x
	y = y + self.y
	return x, y
end

function camera:getAABB()
	-- probably optimizable
	local pts = {
		{x=self.ssx, y=0},
		{x=self.ssx, y=self.ssy},
		{x=0, y=self.ssy},
		{x=0, y=0}
	}
	local minx, maxx, miny, maxy
	for _, v in pairs(pts) do
		local x, y = self:screen2world(v.x, v.y)
		minx = minx and math.min(x, minx) or x
		maxx = maxx and math.max(x, maxx) or x
		miny = miny and math.min(y, miny) or y
		maxy = maxy and math.max(y, maxy) or y
	end
	local x, y, w, h = minx, miny, maxx - minx, maxy - miny
	return x, y, w, h
end

return setmetatable({new=new}, {__call = function(_, ...) return new(...) end})
