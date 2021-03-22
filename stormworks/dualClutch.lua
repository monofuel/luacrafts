-- R is -1, N is 0, then 1-6
gear=0
TOP_GEAR=6

-- TODO add more gears by combining them

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
-- NB. this immediately switches the clutch
-- TODO it could be nice to smoothly switch clutches?

-- TODO sin() / cos() between gear shifts for continuous power?
function setClutch()
	evenClutch = 0
	oddCluch = 0
	-- either clutch could be used for first gear
	if (gear == -1 or gear == 1 or gear == 3 or gear == 5) then
		evenClutch = 0
		oddClutch = 1
	end
	if (gear == 2 or gear == 4 or gear == 6) then
		evenClutch = 1
		oddClutch = 0
	end
end

function setGear()
	if (gear == -1) then
		gearboxR = true
	elseif (gear == 0) then
		-- do nothing, both clutches disengaged
	elseif (gear == 1) then
		-- do nothing
		-- will keep all gearboxes in 1:1 ratio
	elseif (gear == 2) then
		gearbox2 = true
	elseif (gear == 3) then
		gearbox3 = true
	elseif (gear == 4) then
		gearbox4 = true
	elseif (gear == 5) then
		gearbox5 = true
	elseif (gear == 6) then
		gearbox6 = true
	end
end

function onTick()

  -- inputs
	shiftUpInput = input.getBool(1)
	shiftDownInput = input.getBool(2)


    -- shifting gears logic	
	doPopClutch = false

	if (shiftUpInput and not upShifting) then
		upShifting = true
		gear = gear + 1
		doPopClutch = true
	end
	if (not shiftUpInput) then
		upShifting = false
    end

	if (shiftDownInput and not downShifting) then
		downShifting = true
		gear = gear - 1
		doPopClutch = true
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
	if (doPopClutch) then
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
	screen.drawText(2,2, "Gear " .. gearText)
	screen.drawText(2,7, "EClutch " .. evenClutch)
	screen.drawText(2,13, "OClutch " .. oddClutch)
end