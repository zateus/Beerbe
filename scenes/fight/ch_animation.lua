require "utils/multistate_animation"

local characterAnimation = {}

function characterAnimation:load()
    local heroFilenames = {
        "asserts/fight/animations/stand.png",
        "asserts/fight/animations/attack.png",
        "asserts/fight/animations/protect.png",
        "asserts/fight/animations/cast.png",
        "asserts/fight/animations/death.png"
    }

    self.animation = newMultistateAnimation(heroFilenames, 64, 64, 0.11, 3, "bounce")
    self.animation.mp_table = {
        stand = 1,
        attack = 2,
        protect = 3,
        cast = 4,
        death = 5,
    }
    
    self.scale = love.graphics.getHeight()/600
    
    self:setState("stand")
end

function characterAnimation:unload()
    self.screenCoordinates = nil
    self.animation = nil
end

function characterAnimation:setState(st)
    self.animation:setState(st)
    self.animation:play()
end

function characterAnimation:update(dt)
    self.animation:update(dt)
end

function characterAnimation:draw(x, y)
    self.animation:draw(x, y, self.scale)
end

return characterAnimation