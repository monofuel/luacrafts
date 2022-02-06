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
    print(vec:toString())

    -- test get
    assertEqual(vec:get(0), 1)
    assertEqual(vec:get(1), 2)
    assertEqual(vec:get(2), 3)

    -- test __index and __newindex
    vec:set(0, 10)
    assertEqual(vec:get(0), 10)
    assertEqual(vec[0], 10)
    print(vec:toString())
    vec[0] = 15
    assertEqual(vec:get(0), 15)
    assertEqual(vec[0], 15)
    print(vec:toString())

    -- test negative indexes
    assertEqual(vec:get(-1), 3)
    assertEqual(vec:get(-2), 2)
    assertEqual(vec:get(-3), 15)


    -- TODO test pairs, ipairs

end

main()