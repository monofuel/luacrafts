

function validateIndex(index)
    if index < 1 then
        error('invalid index ' .. index)
    end
    if index > 32 then
        error('invalid index ' .. index)
    end
end
-- index ranges 1-32


output = {}
output.values = {}

output.setNumber = function(index, value)
    validateIndex(index)
    
    output.values[index] = value
end

output.setBool = function(index, value) 
    validateIndex(index)
    output.values[index] = value
end


input = {}

input.getBool = function(index)
    validateIndex(index)
    error('not implemented')
end

input.getNumber = function(index)
    validateIndex(index)
    error('not implemented')
end