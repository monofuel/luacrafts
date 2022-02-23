--- Vector library
-- Class with handy functions for array actions
-- inspired by javascript's `Array` class and Lodash
-- Lua tables are great, but it can get confusing when a table has both array and hashmap components.
-- wrapper around table for using it as only an array. Intended to also help with serialization
-- @author monofuel

require('util')

-- TODO implement functions
-- functions()
-- concat
-- insert
-- shift
-- unshift
-- reduce
-- reverse
-- clone
-- filter
-- equals
-- freeze
-- find
-- slice
-- splice
-- isempty
-- Vector:of()
-- toTable

-- TODO improve metatable functions
-- __concat
-- __eq 

function normalizeIndex(i, size) 
    assertType("number", i)
    assertType("number", size)
    if (i >= 1) then
        return i;
    elseif (i == 0) then
        error("invalid index: 0")
    else
        local ret = size + 1 + i
        if (ret < 1) then
            error("negative index larger than size")
        end
        return ret;
    end
end

Vector = {}
VectorMethods = {}

-- create a new Vector
-- similar to C++ Vector or Java Arraylist
-- Vector index starts at 1
-- NB. the underlying table index starts at 1 to preserve order
-- nil is supported as a value type (normally interpreted as end of array)
function Vector:new(size)
    local vec = setmetatable({}, Vector)
    
    -- Lua tables consider 'nil' to be the end of an array
    -- so also keep track of 'size' to know the real nend of the array
    vec.size = (size or 0)
    vec.data = {}
    if (size ~= nil) then
        for i=1, vec.size do
            vec.data[i] = 0
        end
    end
    return vec
end

function Vector:__index(index)
    return VectorMethods[index] or self:get(index)
end

function Vector:__newindex(index, value)
    if (type(index) == "number") then
        return self:set(index, value)
    else
        rawset(self, index, value)
    end
end

function Vector:__len()
    return self.size
end

function Vector:__ipairs()
    local next = 1
    return function()
        if (next >= self.size + 1) then
            return nil
        end
        local k = next
        next = next + 1
        return k, self.data[k]
    end
end

-- __pairs is equivilent to __ipairs for a Vector
-- since we shouldn't have string keys
Vector.__pairs = Vector.__ipairs

function VectorMethods:length()
    return self.size
end

function VectorMethods:push(v) 
    self:set(self.size + 1, v)
end

function VectorMethods:pop()
    if (self.size == 0) then
        return nil
    end

    local result = self:get(self.size)
    self:set(self.size, nil)
    self.size = self.size - 1
    return result
end

function VectorMethods:set(index, value)
    index = normalizeIndex(index, self.size)
    if (index > self.size) then
        self.size = index
    end
    self.data[index] = value
end

function VectorMethods:get(index)
    index = normalizeIndex(index, self.size)
    if (index > self.size) then
        error("index " .. index .. " greater than size " .. self.size)
    end
    return self.data[index]
end

function VectorMethods:each(fn)
    for i, v in ipairs(self.data) do
        fn(i,v)
    end
end

function VectorMethods:map(fn)
    local result = Vector:new(self.size)
    for i, v in ipairs(self.data) do
        result[i] = fn(i,v)
    end
    return result
end

function VectorMethods:reduce(fn)
    local result = nil
    for i, v in ipairs(self.data) do
        result = fn(i, v, result)
    end
    return result
end

function defaultSort(a,b)

end

function VectorMethods:sort(fn)
    
end

-- TODO _eq?
-- I feel like I would assume `==` would check if the array reference is equal,
-- and not do a deep equality. I'd assume equals() would do a deep or shallow comparison

-- shallow inspect arrays for equality
function VectorMethods:equals(vec) 
    if getmetatable(vec) ~= Vector then
        return false
    end
    if (#vec ~= self.size) then
        return false
    end
    for i, v in ipairs(vec) do
        -- TODO deep comparison?
        if self.data[i] ~= v then
            return false
        end
    end
    return true
end

function VectorMethods:join(delim)
    delim = delim or ','
    local result = ""
    -- TODO use a stringbuilder
    self:each(function(i,v)
        if (i == self.size - 1) then
            result = result .. toPrettyPrint(v)
        else
            result = result .. toPrettyPrint(v) .. delim
        end
    end)
    return result
end

function VectorMethods:toString()
    return "[" .. self:join() .. "]"
end

return Vector