-- Tick function that will be executed every logic tick
function onTick()
	-- inputs
	-- 1 temp
	-- 2 batt
	-- 3 throttle
	-- 4 rps
	
	temp = input.getNumber(1)
	batt = input.getNumber(2)
	throttle = input.getNumber(3)
	rps = input.getNumber(4)
	
	-- outputs
	-- 1 air
	-- 2 coolant
	-- 3 fuel
	
	output.setNumber(2,1) -- set coolant pump to 100%
	
	air = throttle
	fuel = throttle / 2
	output.setNumber(1, air)
	output.setNumber(3, fuel)
	
end
