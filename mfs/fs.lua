-- filesystem wrapper functions for linux
-- TODO implementations for open computers / computercraft

-- TODO would be nice to wrap these in a class that can keep track of CWD

function ls(path)
    local pfind = assert(io.popen(("find %s -maxdepth 1 -print0"):format(path), "r"))
    local list = pfind:read('*a')
    pfind:close()
    
    local result = {}
    for filename in list:gmatch('[^\0]+') do
        table.insert(result, filename)
    end
    return result
end

function isDir(path)
    local pfind = assert(io.popen(("file %s"):format(path), "r"))
    local output = pfind:read('*a')
    return string.match(output, "directory%s$") ~= nil
end