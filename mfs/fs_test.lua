require("mfs/fs")
require('util')

testSuite("fs", function()

    doTest("ls()", function()
        -- TODO shouldn't assume on sorted output
        local res = ls("./mfs")
        local expected = {
            "./mfs",
            "./mfs/fs_test.lua",
            "./mfs/fs.lua",
        }
        assertEqual(res, expected)
    end)

    doTest("dir() on file", function()
        local res = isDir("./mfs/fs.lua")
        assertEqual(res, false)
    end)

    doTest("dir() on dir", function()
        local res = isDir("./mfs/")
        assertEqual(res, true)
    end)

end)