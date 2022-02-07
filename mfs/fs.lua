-- filesystem wrapper functions for linux
-- TODO implementations for open computers / computercraft


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