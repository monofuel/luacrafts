
local Lang = require("mlang")

function bundleMain()
    if #arg ~= 1 and #arg ~= 2 then
        print("Expected usage: lua bundle.lua target.lua [output.lua]")
        return
    end

    local targetFile = arg[1]
    local outputFile = arg[2]

    -- TODO use mlang to parse the targetfile and unroll 'require'
    target = Lang:new(targetFile)
    -- TODO print the parsed syntax tree to the output
end

bundleMain()