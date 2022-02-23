require('util')
local Hashmap = require("mlib/hashmap")

testSuite("hashmap", function() 

    doTest("create hashmap", function()
        local map = Hashmap:new()
        assertEqual(#map, 0)
    end)

    doTest("add to hashmap", function()
        local map = Hashmap:new()
        map['A'] = 1
        assertEqual(#map, 1)
        map['B'] = 2
        map['C'] = 3
        assertEqual(#map, 3)

        assertEqual(map['A'], 1)
        assertEqual(map['B'], 2)
        assertEqual(map['C'], 3)
    end)

    doTest("delete from hashmap", function()
        local map = Hashmap:new()
        map['A'] = 1
        map['B'] = 2
        map['C'] = 3

        map['B'] = nil
        assertEqual(#map, 2)
        assertEqual(map['B'], nil)
        map['C'] = nil
        map['A'] = nil
        assertEqual(#map, 0)
    end)
end)