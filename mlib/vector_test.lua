-- TODO figure out stuff on relative imports
local Vector = require('mlib/vector')
require('util')

testSuite("vector", function()
    doTest("create new", function()
        local vec = Vector:new()
        assertEqual(vec:length(), 0)
    end)

    doTest("push() and length()", function()
        local vec = Vector:new()
        vec:push(1)
        assertEqual(vec:length(), 1)
        vec:push(2)
        assertEqual(vec:length(), 2)
        vec:push(3)
        assertEqual(vec:length(), 3)
        assertEqual(vec:length(), #vec)
    end)

    doTest("get()", function()
        local vec = Vector:new()
        vec:push(1)
        vec:push(2)
        vec:push(3)

        assertEqual(vec:get(1), 1)
        assertEqual(vec:get(2), 2)
        assertEqual(vec:get(3), 3)
    end)

    doTest("__index and __newindex", function()
        local vec = Vector:new()
        vec:push(1)
        vec:push(2)
        vec:push(3)

        vec:set(1, 10)
        assertEqual(vec:get(1), 10)
        assertEqual(vec[1], 10)
        
        vec[1] = 15
        assertEqual(vec:get(1), 15)
        assertEqual(vec[1], 15)
    end)

    
    doTest("negative indexes", function()
        local vec = Vector:new()
        vec:push(15)
        vec:push(2)
        vec:push(3)

        assertEqual(vec:get(-1), 3)
        assertEqual(vec:get(-2), 2)
        assertEqual(vec:get(-3), 15)
    end)

    doTest("pop()", function()
        local vec = Vector:new()
        vec:push(15)
        vec:push(2)
        vec:push(3)
    
        assertEqual(vec:pop(), 3)
        assertEqual(vec:pop(), 2)
        assertEqual(vec:pop(), 15)
        assertEqual(vec:pop(), nil)
        assertEqual(#vec, 0)
    end)
    
    doTest("each()", function()
        local vec = Vector:new()
        vec:push(15)
        vec:push(2)
        vec:push(3)

        local count = 0
        vec:each(function(i, v)
            assertEqual(count, i - 1)
            count = count + 1
            if (i == 1) then
                assertEqual(v, 15)
            elseif (i == 2) then
                assertEqual(v, 2)
            elseif (i == 3) then 
                assertEqual(v, 3)
            else
                error("invalid index when mapping: " .. i)
            end
        end)
        assertEqual(count, 3)
    end)

    doTest("map()", function()
        local vec = Vector:new()
        vec:push(15)
        vec:push(2)
        vec:push(3)

        local mapResult = vec:map(function(i, v)
            return v + 5;
        end)
        assertEqual(mapResult:get(1), 20)
        assertEqual(mapResult:get(2), 7)
        assertEqual(mapResult:get(3), 8)
        assertEqual(#mapResult, 3)
    end)
    
    doTest("reduce()", function() 
        local vec = Vector:new()
        vec:push(15)
        vec:push(2)
        vec:push(3)

        local reduceResult = vec:reduce(function(i, v, result)
            result = result or 0
            return result + v;
        end)
        assertEqual(reduceResult, 3 + 2 + 15)
        
    end)

    doTest("pairs()", function()
        local vec = Vector:new()
        vec:push(15)
        vec:push(2)
        vec:push(3)

        local count = 0
        for i, v in pairs(vec) do
            assertEqual(count, i - 1)
            count = count + 1
            if (i == 1) then
                assertEqual(v, 15)
            elseif (i == 2) then
                assertEqual(v, 2)
            elseif (i == 3) then 
                assertEqual(v, 3)
            else
                error("invalid index in pairs(): " .. i)
            end
        end
    end)

    doTest("ipairs()", function()
        local vec = Vector:new()
        vec:push(15)
        vec:push(2)
        vec:push(3)

        local count = 0
        for i, v in ipairs(vec) do
            assertEqual(count, i - 1)
            count = count + 1
            if (i == 1) then
                assertEqual(v, 15)
            elseif (i == 2) then
                assertEqual(v, 2)
            elseif (i == 3) then 
                assertEqual(v, 3)
            else
                error("invalid index in ipairs(): " .. i)
            end
        end
    end)

end)