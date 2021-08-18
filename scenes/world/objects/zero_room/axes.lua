local obj = {
	id = 6,
	image = love.graphics.newImage("assets/world/objects/zero_room/axes.png"),
	position = {},
	width = 1,
	height = 1
}

function obj:init(initData)
end

function obj:onStartCollide(moving)
end

function obj:update(dt)
end

function obj:draw(camera)
	love.graphics.draw(self.image, self.position.x, self.position.y)
end

return obj