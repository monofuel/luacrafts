require('util')

-- TODO implement functions
-- functions()
-- concat
-- pop
-- insert
-- shift
-- unshift
-- map
-- reduce
-- reverse
-- clone
-- filter
-- find
-- each
-- slice
-- splice
-- isempty
-- Vector:of()
-- toTable

-- TODO improve metatable functions
-- __concat __pairs
-- __eq 

function normalizeIndex(i, size) 
    assertType("number", i)
    assertType("number", size)
    if (i >= 0) then
        return i + 1;
    else
        local ret = size + i + 1
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
-- Vector index starts at 0
-- NB. the underlying table index starts at 1 to preserve order
-- nil is supported as a value type (normally interpreted as end of array)
function Vector:new(size)
    local vec = setmetatable({}, Vector)
    
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

function VectorMethods:length()
    return self.size
end

function VectorMethods:push(v) 
    self:set(self.size, v)
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

function VectorMethods:toString()
    -- TODO better pretty print
    return toPrettyPrint(self.data)
end

return Vector