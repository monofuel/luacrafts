-- TODO figure out stuff on relative imports
local Vector = require('mlib/vector')
require('util')

function main()
    local vec = Vector:new()
    assertEqual(vec:length(), 0)

    vec:push(1)
    assertEqual(vec:length(), 1)
    vec:push(2)
    assertEqual(vec:length(), 2)
    vec:push(3)
    assertEqual(vec:length(), 3)
    assertEqual(vec:length(), #vec)
    print(vec:toString())

    assertEqual(vec:get(0), 1)
    assertEqual(vec:get(1), 2)
    assertEqual(vec:get(2), 3)

    vec:set(0, 10)
    assertEqual(vec:get(0), 10)
    print(vec:toString())



    -- TODO test pairs, ipairs

end

main()