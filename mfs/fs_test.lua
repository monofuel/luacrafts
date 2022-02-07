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
end

main()