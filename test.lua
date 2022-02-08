require("mfs/fs")
require("util")

function runTestFile(file)
    print("## Running tests: " .. file)
    dofile(file)
end

function runDirTests(dir)
    -- recurse to sub directories
    -- if a file, check if _test.lua and run
    local files = ls(dir)

    for i, v in ipairs(files) do
        if (v == dir) then
            -- skip
        else
            if isDir(v) then
                runDirTests(v)
            else
                if string.match(v, "_test.lua$") then
                    runTestFile(v)
                end
            end
        end
    end
end

runDirTests(".")
print("## Success!")