-- TODO figure out stuff on relative imports
local Vector = require('mlib/vector')
require('util')

function main()
    local vec = Vector:new()
    assertEqual(vec:length(), 0)

    -- test push and length
    vec:push(1)
    assertEqual(vec:length(), 1)
    vec:push(2)
    assertEqual(vec:length(), 2)
    vec:push(3)
    assertEqual(vec:length(), 3)
    assertEqual(vec:length(), #vec)

    -- test get
    assertEqual(vec:get(1), 1)
    assertEqual(vec:get(2), 2)
    assertEqual(vec:get(3), 3)

    -- test __index and __newindex
    vec:set(1, 10)
    assertEqual(vec:get(1), 10)
    assertEqual(vec[1], 10)

    vec[1] = 15
    assertEqual(vec:get(1), 15)
    assertEqual(vec[1], 15)

    -- test negative indexes
    assertEqual(vec:get(-1), 3)
    assertEqual(vec:get(-2), 2)
    assertEqual(vec:get(-3), 15)

    -- test each
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

    -- test map
    local mapResult = vec:map(function(i, v)
        return v + 5;
    end)
    assertEqual(mapResult:get(1), 20)
    assertEqual(mapResult:get(2), 7)
    assertEqual(mapResult:get(3), 8)
    assertEqual(#mapResult, 3)

    -- test reduce
    local reduceResult = vec:reduce(function(i, v, result)
        result = result or 0
        return result + v;
    end)
    assertEqual(reduceResult, 3 + 2 + 15)

    -- test pairs, ipairs
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

    -- test pop
    assertEqual(vec:pop(), 3)
    assertEqual(vec:pop(), 2)
    assertEqual(vec:pop(), 15)
    assertEqual(vec:pop(), nil)
    assertEqual(#vec, 0)

end

main()