require('util')

-- TODO implement functions
-- functions()
-- __concat
-- concat
-- pop
-- insert
-- shift
-- unshift
-- map
-- foreach

Vector = {}

-- create a new Vector
-- similar to C++ Vector or Java Arraylist
-- Vector index starts at 0
-- NB. the underlying table index starts at 1 to preserve order
function Vector:new(size)
    local meta = {
        __index = Vector,
        __len = getSize,
    }
    local vec = setmetatable({}, meta)
    
    vec.size = (size or 0)
    vec.data = {}
    if (size ~= nil) then
        for i=1, vec.size do
            vec.data[i] = 0
        end
    end
    return vec
end

function Vector:length()
    return getSize(self)
end

function getSize(vec) 
    return vec.size
end

function Vector:push(v) 
    self.data[self.size + 1] = v
    self.size = self.size + 1
end

function Vector:set(index, value)
    assertType("number", index)
    if (index < 0) then
        error("index must be positive but got " .. index)
    elseif (index > self.size) then
        self.size = index + 1
    end
    self.data[index + 1] = value
end

function Vector:get(index)
    assertType("number", index)
    if (index < 0) then
        error("index must be positive but got " .. index)
    elseif (index > self.size) then
        error('index out of bounds, got ' .. index .. ' but size is ' .. self.size)
    end
    return self.data[index + 1]
end

function Vector:toString()
    -- TODO better pretty print
    return toPrettyPrint(self.data)
end

return Vector