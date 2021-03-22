require("./testUtil")
require("./dualClutch")


function testZeroCase()
    input.values[1] = false
    input.values[2] = false
    onTick()
    assertOutput(1, 0);
    assertOutput(2, 0);
    assertOutput(3, false);
    assertOutput(4, false);
    assertOutput(5, false);
    assertOutput(6, false);
    assertOutput(7, false);
    assertOutput(8, false);
end

function testFirstGear()
    input.values[1] = false
    input.values[2] = false
    
    onTick()
    input.values[1] = true
    onTick()
    input.values[1] = false

    assertOutput(1, 1);
    assertOutput(2, 0);
    assertOutput(3, false);
    assertOutput(4, false);
    assertOutput(5, false);
    assertOutput(6, false);
    assertOutput(7, false);
    assertOutput(8, false);
end

function testSecondGear()
    input.values[1] = false
    input.values[2] = false
    
    onTick()
    input.values[1] = true
    onTick()
    input.values[1] = false

    assertOutput(1, 0);
    assertOutput(2, 1);
    assertOutput(3, false);
    assertOutput(4, true);
    assertOutput(5, false);
    assertOutput(6, false);
    assertOutput(7, false);
    assertOutput(8, false);
end

function testSeventhGear()
    input.values[1] = false
    input.values[2] = false
    
    onTick()
    input.values[1] = true
    onTick()
    input.values[1] = false

    onTick()
    input.values[1] = true
    onTick()
    input.values[1] = false

    onTick()
    input.values[1] = true
    onTick()
    input.values[1] = false

    onTick()
    input.values[1] = true
    onTick()
    input.values[1] = false

    onTick()
    input.values[1] = true
    onTick()
    input.values[1] = false

    assertOutput(1, 1); -- odd clutch
    assertOutput(2, 0); -- even clutch
    assertOutput(3, false); -- R
    assertOutput(4, false); -- 2
    assertOutput(5, true);
    assertOutput(6, false);
    assertOutput(7, true);
    assertOutput(8, false);
end

function testEighthGear()
    input.values[1] = false
    input.values[2] = false
    
    onTick()
    input.values[1] = true
    onTick()
    input.values[1] = false

    assertOutput(1, 1); -- odd clutch
    assertOutput(2, 0); -- even clutch
    assertOutput(3, false); -- R
    assertOutput(4, false); -- 2
    assertOutput(5, false);
    assertOutput(6, true);
    assertOutput(7, false);
    assertOutput(8, true);
end

-- TODO should reset between test cases
testZeroCase()
testFirstGear()
testSecondGear()
testSeventhGear()