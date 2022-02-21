require('util')
local Hashmap = require("mlib/hashmap")

testSuite("hashmap", function() 

    doTest("create hashmap", function()
        local map = Hashmap:new()
        assertEqual(false,true)
        assertEqual(map:length(), 0)
    end)
end)