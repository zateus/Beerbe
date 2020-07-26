local target = {
    index = 1,
    rotate = 0,
    spell = ""
}

target.image = love.graphics.newImage("asserts/fight/select.png")

target.positions = {}
local slots = require "scenes/fight/slots"
for i = 1, #slots - 1 do
    target.positions[i] = {}
    target.positions[i].x = slots[i].x - 0.0125*love.graphics.getWidth()
    target.positions[i].y = slots[i].y + 0.016667*love.graphics.getHeight()
end

function target:left()
    self.index = self.index - 1
    if self.index <= 0 then
        self.index = #self.positions
    end
end
function target:right()
    self.index = self.index + 1
    if self.index > #enemies then
        self.index = 1
    end
end

function target:draw()
    love.graphics.draw(self.image, self.positions[self.index].x, self.positions[self.index].y, 0, love.graphics.getHeight()/1200)
end

return target