#!/usr/bin/lua5.3

function bundleMain()
    if #arg ~= 1 and #arg ~= 2 then
        print("Expected usage: ./bundle.lua target.lua [output.lua]")
        return
    end

    local targetFile = arg[1]
    local outputFile = arg[2]
    print(targetFile)
end

bundleMain()