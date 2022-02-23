-- Hashmap library
-- Class for making a safe Hashmap object, and functions for working with them.
-- Inspired by javascript's `Object` class
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

-- TODO more Hashmap methods

return Hashmap