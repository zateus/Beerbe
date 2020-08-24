local obj = {
    id = 16,
    animation = newAnimation(love.graphics.newImage("asserts/world/objects/chest.png"), 48, 96, 0.1, 3),
    isPassable = false,
    position = {},
    width = 1,
    height = 1,
    isOpened = false
}

local character = require "character"
local items = require "items"

obj.animation:stop()
obj.animation:setMode("once")

function obj:onCollide(moving)
    if not self.isOpened then
        moving.info.isShown = true
        moving.info.text = "Open chest?"
        moving.info.onConfirm = self.onConfirm
    end
end

function obj.onConfirm(moving)
    local itemsToGive = { 1, 2, 2 }

    for i = 1, #itemsToGive do
        character.bag[#character.bag + 1] = itemsToGive[i]
    end
    
    obj.animation:play()
    obj.isOpened = true
    
    local replicas = {
        "You got \"Novice sword\"",
        "You got \"Beer 0.3l\" x2"
    }

    moving:startDialogue(replicas)
end

function obj:update(dt)
    self.animation:update(dt)
end

function obj:draw(tileSide)
    self.animation:draw(tileSide * self.position.x, tileSide * self.position.y)
end

return obj