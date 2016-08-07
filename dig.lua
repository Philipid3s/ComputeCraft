-- slot 1 : lava cells / coal

local blacklist = {
	"minecraft:stone",
	"minecraft:dirt",
	"minecraft:grass",
	"minecraft:gravel",
	"minecraft:sand",
	"minecraft:clay",
	"minecraft:water",
	"minecraft:lava",
	"minecraft:monster_egg"
}
local _blist = {}

-- Inverse blacklist for fast hashmap lookup
for i = 1, #blacklist do
 	_blist[blacklist[i]] = true
end

function refuel()
	-- refuel if necessary
	if turtle.getFuelLevel() ~= "unlimited" and turtle.getFuelLevel() < 100 then 
		turtle.select(1)
		turtle.refuel(1)
		print("refuel done: ", turtle.getFuelLevel())
	end
end

function dig()
	temp, blk = turtle.inspect()
	
	if _blist[blk["name"]] then
		return false
	end
		
	return turtle.dig()
end

local drill = true
local depth = 0

local mineshaft = false
local dungeon = false
local lava = false
local water = false

while drill do
	refuel()

	success, block = turtle.inspectDown()
	
	if success then
		if block.name == "minecraft:bedrock" then
			drill = false
		elseif block.name == "minecraft:planks" then
			drill = false
			mineshaft = true
		elseif block.name == "minecraft:wooden_slab" then
			drill = false
			mineshaft = true
		elseif block.name == "minecraft:double_wooden_slab" then
			drill = false
			mineshaft = true
		elseif block.name == "minecraft:cobblestone" then
			drill = false
			dungeon = true
		elseif block.name == "minecraft:mossy_cobblestone" then
			drill = false
			dungeon = true 
		elseif block.name == "minecraft:stonebrick" then
			drill = false
			dungeon = true
		elseif block.name == "minecraft:lava" then
			drill = false
			lava = true
		elseif block.name == "minecraft:water" then
			drill = false
			water = true
		end
	else
		-- air under >> cave !
		print("Cave: ", depth)
	end
	
			
	if drill then
			
		---------- dig down ----------
		if success then -- if false : air / no need to dig down
			turtle.digDown() 
		end
		
		if turtle.down() then 
			depth = depth + 1 
					
			for j=1,4 do
				dig()
				turtle.turnLeft()
			end
		else
			print("turtle.down(): ", turtle.down())
			drill = false
		end
		------------------------------
		
	end
end

-- climb up to top level
for i=0,depth do
	refuel()
	turtle.up()
end

if dungeon then
	print("Dungeon: ", depth)
elseif mineshaft then
	print("Mineshaft: ", depth)
elseif lava then
	print("Lava: ", depth)
elseif water then
	print("Water: ", depth)
else
	print("Bedrock: ", depth)
end