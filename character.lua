require "items"

local character = {
	name = "Миша",
	position = {
		room = 1
	},

	-- current values
    health = 15,
	mana = 5,
	
	-- usages numbers
    passive_skills = {
		health = 1,
		mana = 1
	},
    active_skills = {
		thunder = 0
	},

	bag = { 1, 2 }, -- index from items table
	equipped = {
		right_hand = 1 -- index from bag
	}
}

function character:getMaxHealth()
	return 15 * self:getSkillLevel("health")
end

function character:getMaxMana()
	return 5 * self:getSkillLevel("mana")
end

function character:getSkillTitle(name)
	-- format for displaying "right_hand" -> "Right hand"
	return name:gsub("_", " "):gsub("^%l", string.upper)
end

function character:getSkillUsages(skill)
	if self.passive_skills[skill] ~= nil then
		return self.passive_skills[skill]
	end
	if self.active_skills[skill] ~= nil then
		return self.active_skills[skill]
	end
	return 0
end

function character:getSkillLevel(skill)
	return math.ceil(self:getSkillUsages(skill)/10)
end

function character:increasePassiveSkill(skill)
	if self.passive_skills[skill] == nil then
		self.passive_skills[skill] = 0
	end
	self.passive_skills[skill] = self.passive_skills[skill] + 1
end

function character:increaseActiveSkill(skill)
	if self.active_skills[skill] == nil then
		self.active_skills[skill] = 0
	end
	self.active_skills[skill] = self.active_skills[skill] + 1
end

function character:getDamage(skill)
	local damage = 0
	
	if skill == "attack" then
		if self.equipped.right_hand ~= nil then
			damage = items[self.bag[self.equipped.right_hand]].damage
		end
		if self.equipped.left_hand ~= nil then
			damage = damage + items[self.bag[self.equipped.left_hand]].damage
		end

		damage = damage * self:getSkillLevel("sword")		
		
	else
		damage = self:getSkillLevel("mana") * self:getSkillLevel(skill)
	end
	
	return damage
end

function character:useSkill(skill)
	local damage = self:getDamage(skill)
	if skill == "attack" then
		self:increasePassiveSkill("sword")
	else
		self.mana = self.mana - self:getSkillLevel(skill)
		self:increaseActiveSkill(skill)
		self:increasePassiveSkill("mana")
	end

	print("char_deal: "..damage)
	return damage
end

function character:takeDamage(damage)
	if damage > 0 then
		self.health = self.health - damage
		self:increasePassiveSkill("health")
		print("char_take: "..damage)
	end
end

return character