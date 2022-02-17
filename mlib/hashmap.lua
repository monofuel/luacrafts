require("util")

function normalizeKey(key)
    if (type(key) == "number") then
        key = tostring(key)
    end
    assertType("string", key)
    return key
end
-- TODO
-- map structure
-- count

-- functions()
-- new map
-- put
-- get
-- delete value
-- delete table
-- pretty print


Hashmap = {}
HashmapMethods = {}
function Hashmap:new()
    local map = setmetatable({}, Hashmap)
    map.data = {}
    map.size = 0
    return map
end

function Hashmap:__index(index)
    return HashmapMethods[index] or self:get(index)
end

-- TODO figure this out for map
-- function Hashmap:__newindex(index, value)
--     if (type(index) == "number") then
--         return self:set(index, value)
--     else
--         rawset(self, index, value)
--     end
-- end

function Hashmap:__len()
    return self.size
end

function HashmapMethods:length()
    return self.size
end

return Hashmap