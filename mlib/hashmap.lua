-- Hashmap library
-- Class for making a safe Hashmap object, and functions for working with them.
-- Inspired by javascript's `Object` class and Lodash
-- Lua tables are great, but it can get confusing when a table has both array and hashmap components.
-- wrapper around table for using it as only a hashmap. Intended to also help with serialization

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
-- pretty print


Hashmap = {}
HashmapMethods = {}

-- create a new Hashmap
-- similar to a javascript Object
-- keys must be strings, index keys will be converted to strings
-- KV pair sort is not guarenteed
function Hashmap:new()
    local map = setmetatable({}, HashmapMethods)

    -- Getting the length of a table in Lua only considers the 'array' portion
    -- so keep track of it's size to know how many keys are in the table
    rawset(map, "size", 0)
    rawset(map, "data", {})
    return map
end

function HashmapMethods:__index(index)
    index = normalizeKey(index)
    local data = rawget(self, 'data')
    return data[index]
end

function HashmapMethods:__newindex(index, value)
    index = normalizeKey(index)
    local size = rawget(self, 'size')
    local data = rawget(self, 'data')

    -- if we are adding a value, increment the size
    if (data[index] == nil and value ~= nil) then
        rawset(self, 'size', size + 1)
    end

    -- if we are deleting a value, decrement
    if (data[index] ~= nil and value == nil) then
        rawset(self, 'size', size - 1)
    end

    data[index] = value
end

function HashmapMethods:__len()
    return self.size
end

-- create a Hashmap from a table
function Hashmap:of()
    -- TODO
end

-- produce a Vector of [key, value] pairs
function Hashmap:entries(map) 
    local result = Vector:new(#map)
    for k, v in pairs() do
        local entry = {}
        entry[0] = k
        entry[1] = v
        result.push(entry)
    end
    return result;

end

-- pretty print the hashmap
function Hashmap:toString()
    -- TODO
end

-- prevent the hashmap from being modified
function Hashmap:freeze()
    -- TODO
end

-- deep equality between hashmaps
function Hashmap:equals()
    -- TODO
end

-- Vector of keys in the hashmap
function Hashmap:keys(map)
    local result = Vector:new(#map)
    for k, v in pairs() do
        result.push(k)
    end
    return result;
end

-- Vector of values in the hashmap
function Hashmap:values()
    local result = Vector:new(#map)
    for k, v in pairs() do
        result.push(v)
    end
    return result;
end

return Hashmap