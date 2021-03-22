-- R is -1, N is 0, then 1-6
-- 7 is 3 + 5
-- 8 is 4 + 6

TOP_GEAR=8
-- CLUTCH_TICKS is how many ticks to engage clutch
CLUTCH_TICKS=60
-- CLUTCH_OFFSET is the gap between engaging and disengaging each clutch
CLUTCH_OFFSET=50


gear=0
previousGear = 0
clutchTick = 0
upShifting = false
downShifting = false

evenClutch = 0
oddClutch = 0
gearboxR = false
gearbox2 = false
gearbox3 = false
gearbox4 = false
gearbox5 = false
gearbox6 = false

function clearGears()
	gearboxR = false
	gearbox2 = false
	gearbox3 = false
	gearbox4 = false
	gearbox5 = false
	gearbox6 = false

end

function writeOutputs()
  -- outputs
  -- 1 number OddClutch
  output.setNumber(1, oddClutch)
  -- 2 number EvenClutch
  output.setNumber(2, evenClutch)
  -- 3 bool GearboxR
  output.setBool(3,gearboxR)
  -- first gear is every gearbox set false
  -- 4 bool Gearbox2
  output.setBool(4,gearbox2)
  -- 5 bool Gearbox3
  output.setBool(5,gearbox3)
  -- 6 bool Gearbox4
  output.setBool(6,gearbox4)
  -- 7 bool Gearbox5
  output.setBool(7,gearbox5)
  -- 8 bool Gearbox6
  output.setBool(8,gearbox6)
end

-- sets the clutch for the appropriate gear
function setClutch()

    local c = (clutchTick / CLUTCH_TICKS) * (math.pi / 2)
    if clutchTick > CLUTCH_TICKS then
        c = math.pi / 2
    end
    local c2 = 0
    if (clutchTick > CLUTCH_OFFSET) then
        c2 = ((clutchTick - CLUTCH_OFFSET) / CLUTCH_TICKS) * (math.pi / 2)
    end
    
	evenClutch = 0
	oddCluch = 0

    if (gear == -1 or gear == 1 or gear == 3 or gear == 5 or gear == 7) then
        if clutchTick == CLUTCH_TICKS + CLUTCH_OFFSET then
            evenClutch = 0
            oddClutch = 1
        else
            evenClutch = math.cos(c) -- approaching 0
            oddClutch = math.sin(c2) -- approaching 1
        end
	end
    if (gear == 2 or gear == 4 or gear == 6 or gear == 8) then
        if clutchTick == CLUTCH_TICKS + CLUTCH_OFFSET then
            evenClutch = 1
            oddClutch = 0
        else
            evenClutch = math.sin(c2) -- approaching 1
            oddClutch =  math.cos(c) -- approaching 0
        end
    end
    
    clutchTick = clutchTick + 1
    if clutchTick > CLUTCH_TICKS + CLUTCH_OFFSET then
        clutchTick = 0
    end

    if gear == 0 then
        oddClutch = 0
        evenClutch = 0
    end
end

function setGear()

    -- also engage the previous gear, such that we can smoothly clutch between gears

	if (gear == -1 or previousGear == -1) then
        gearboxR = true
    end
	if (gear == 0 or previousGear == 0) then
        -- do nothing, both clutches disengaged
    end
	if (gear == 1) then
		-- do nothing
        -- will keep all gearboxes in 1:1 ratio
    end
	if (gear == 2 or previousGear == 2) then
        gearbox2 = true
    end
	if (gear == 3 or previousGear == 3) then
        gearbox3 = true
    end
	if (gear == 4 or previousGear == 4) then
        gearbox4 = true
    end
	if (gear == 5 or previousGear == 5) then
		gearbox5 = true
    end
    if (gear == 6 or previousGear == 6) then
        gearbox6 = true
    end
    if (gear == 7 or previousGear == 7) then
        gearbox3 = true
        gearbox5 = true
    end
    if (gear == 8 or previousGear == 8) then
        gearbox4 = true
        gearbox6 = true
	end
end

function onTick()

  -- inputs
	shiftUpInput = input.getBool(1)
	shiftDownInput = input.getBool(2)


	if (shiftUpInput and not upShifting and clutchTick == 0) then
        upShifting = true
        previousGear = gear
		gear = gear + 1
		clutchTick = 1
	end
	if (not shiftUpInput) then
		upShifting = false
    end

	if (shiftDownInput and not downShifting  and clutchTick == 0) then
        downShifting = true
        previousGear = gear
		gear = gear - 1
		clutchTick = 1
	end
	if (not shiftDownInput) then
		downShifting = false
    end
	
	if (gear > TOP_GEAR) then
		gear = TOP_GEAR
	end
	if (gear < -1) then
		gear = -1
	end
	
	-- update values
	clearGears()
	if clutchTick ~= 0 then
		setClutch()
	end
	setGear()
	writeOutputs()
  
end

-- Draw function that will be executed when this script renders to a screen
function onDraw()
    -- characters are 4 wide, 5 tall
	gearText = gear
	if (gear == 0) then
		gearText = "N"
	end
	if (gear == -1) then
	    gearText = "R"
    end
    
    prevGearText = previousGear
    if (previousGear == 0) then
		prevGearText = "N"
	end
	if (previousGear == -1) then
	    prevGearText = "R"
    end
    screen.drawText(2,2, "Gear " .. gearText)
    screen.drawText(2,7, "Prev " .. prevGearText)
	screen.drawText(2,13, "EClutch " .. evenClutch)
	screen.drawText(2,18, "OClutch " .. oddClutch)
end