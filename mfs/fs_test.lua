require("mfs/fs")
require('util')

function main()
    -- TODO shouldn't assume on sorted output
    local res = ls("./mfs")
    local expected = {
        "./mfs",
        "./mfs/fs_test.lua",
        "./mfs/fs.lua",
    }
    assertEqual(res, expected)

    local res = isDir("./mfs/fs.lua")
    assertEqual(res, false)

    local res = isDir("./mfs/")
    assertEqual(res, true)
end


main()