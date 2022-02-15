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
    fn()
    print("\27[32m### " .. currentSuite .. " : " .. name)
    io.write("\27[0m")
end

function skipTest(name, fn)
    print("\27[33m### " .. currentSuite .. " : " .. name)
    print('\t SKIPPING TEST')
    io.write("\27[0m")
end