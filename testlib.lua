-- TODO

currentSuite = ""

function testSuite(name, fn)
    currentSuite = name
    print("## " .. currentSuite)
    fn()
end

function doTest(name, fn)
    -- TODO should catch error and color output
    -- if we do catch an error, make sure test returns non-zero status code
    local status, err = pcall(fn)
    if status == true then
        print("\27[32m### " .. currentSuite .. " : " .. name)
        io.write("\27[0m")
        testSuccessCount = testSuccessCount + 1
    else
        print("\27[31m### " .. currentSuite .. " : " .. name)
        -- print("\27[31m " .. toPrettyPrint(err))
        -- HACK. throwing error for now to get pretty stacktraces
        error(err)
        io.write("\27[0m")
        testFailureCount = testFailureCount + 1
    end
end

function skipTest(name, fn)
    print("\27[33m### " .. currentSuite .. " : " .. name)
    print('\t SKIPPING TEST')
    io.write("\27[0m")
    testSkippedCount = testSkippedCount + 1
end