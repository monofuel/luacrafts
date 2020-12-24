local io = require("io")

function lang_tokenize(input)
    local lineNo = 1
    -- input helpers
    function next(n)
        local n = n or 1
        local c = input:read(n)
        for i in c:gmatch("\n") do
            lineNo = lineNo + 1
        end
        return c
    end
    function peek(n)
        n = n or 1
        local c = input:read(n)
        input:seek("cur", -n)
        return c
    end
    function eol()
        local c = peek()
        return c == nil
    end

    function getLine()
        local line = ""
        while peek() ~= '\n' do
            line = line .. next()
        end
        next() -- eat up the newline
        return line
    end

    function eatWhitespace()
        -- om nom nom nom nom nom nom nom nom
        -- while peek():match('%s') do
        --     next()
        -- end
        while true do
            str = peek()
            if (str == nil) then
                next()
                break
            end

            if not str:match('%s') then
                break
            else 
                next()
            end
            
        end 
    end

    -- actual tokenizer
    return function()
        function token_error()
            local line = getLine() or ""
            local offset = input:seek('cur')
            error('unexpected on line ' .. tostring(lineNo).. ' : "' .. line .. '" at offset ' .. tostring(offset))
        end

        eatWhitespace()

        local offset = input:seek('cur')

        if eol() then
            print('EOL')
            return nil
        elseif peek(2) == '--' then
            local line = getLine()
            print('found comment', line)
            return {
                type = 'comment',
                value = line
            }
        elseif peek():match('%d') then
            local num = next()
            while peek():match('[%d\\.x]') do
                num = num .. next()
            end
            return {
                type = 'number',
                value = num
            }
        elseif peek():match('[%a_]') then
            local word = next()
            while peek():match('[%a%dz_]') do
                word = word .. next()
            end
            return {
                type = 'keyword',
                value = word
            }
        elseif peek():match('["\']') then
            local quote = next()
            local str = quote
            local escaped = false
            while escaped or not peek():match(quote) do 
                local c = next()
                if (escaped) then
                    str = str .. c
                    escaped = false
                elseif c == '\\' then
                    escaped = true
                else
                    str = str .. c
                end
            end
            str = str .. next()
            
            return {
                type = 'string',
                value = str
            }
        elseif peek():match('%p') then
            -- TODO punctuation & operators
            if peek():match('[\\(\\)\\{\\}\\,]') then
                return {
                    type = 'punctuation',
                    value = next()
                }
            elseif peek(2) == '~=' or peek(2) == '==' then
                return {
                    type = 'operator',
                    value = next(2)
                }
            elseif peek():match('[;#\\.:=\\+\\-]') then
                return {
                    type = 'operator',
                    value = next()
                }
            end
            token_error()
        else
            token_error()
        end
    end
end

-- Identifiers
-- and break do else elseif end false for
-- function if in local nil not or
-- repeat return then true until while

function tohex(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end

local Lang = {}

function Lang:new(filepath)
    local lang = setmetatable({}, { __index = Lang })

    file = io.open(filepath, "r")


    lang.block = {}
  
    -- for c in file:lines() do
    --   print(c)
    -- end

    for token in lang_tokenize(file) do

        print("token -- type: ",  token.type, " value: ", token.value)
    end

    return lang
end

function edgeCases()
    local a, b

    a = 5; b = 
    2 a=3
end

return Lang
