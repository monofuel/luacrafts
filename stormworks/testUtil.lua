

function validateIndex(index)
    if index < 1 then
        error('invalid index ' .. index)
    end
    if index > 32 then
        error('invalid index ' .. index)
    end
end

function validateTypes(t, index, value)
    local val = t[index]
    if type(val) == 'nil' then
        return;
    end
    if type(val) ~= type(value) then
        error("type mismatch on index " .. index .. " | " .. type(val) .. " : " .. type(value))
    end
end

function assertOutput(index, value)
    assert(
        output.values[index] == value,
        tostring(index) .. " | " .. tostring(output.values[index]) .. " : " .. tostring(value)
    )
end
-- index ranges 1-32


output = {}
output.values = {}

output.setNumber = function(index, value)
    validateIndex(index)
    validateTypes(output, index, value)
    output.values[index] = value

end

output.setBool = function(index, value) 
    validateIndex(index)
    validateTypes(output, index, value)
    output.values[index] = value
end


input = {}
input.values = {}

input.getBool = function(index)
    validateIndex(index)
    validateTypes(input, index, value)

    if type(input.values[index]) == 'nil' then
        error('undefined input ' .. index)
    end
    -- TODO assert is bool
    return input.values[index]
end

input.getNumber = function(index)
    validateIndex(index)
    validateTypes(input, index, value)

    if type(input.values[index]) == 'nil' then
        error('undefined input ' .. index)
    end
    -- TODO assert is number
    return input.values[index]
end