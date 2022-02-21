require("mfs/fs")
require("testlib")

function runTestFile(file)
    io.write("\27[0m")
    print("# Running tests: " .. file)
    dofile(file)
end

testSuccessCount = 0
testFailureCount = 0
testSkippedCount = 0

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
-- TODO should print stats (passed, skipped, failed)
if testFailureCount ~= 0  then
    print( testFailureCount .. " tests failed")
else
    print("# Success!")
end