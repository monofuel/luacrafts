local io = require("io")
require("./util")

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

-- TODO should probably be recursive for function blocks
function generate_ast(input) 
    block = {
        type = "block",
        contents = {}
    }

    tokens = {}
    for token in lang_tokenize() do
        table.insert(tokens,token)
    end

    local next = function() return table.remove(tokens, 1) end
    local peek = function() return table[1] end


    for token in next do

        function token_err() 
            error("unhandled token: " .. toPrettyPrint(token))
        end

        function pop_expression()
            local expression = {
                type = "expression",
                contents = {}
            }

            local token1 = next()
            print(toPrettyPrint(token1))

            local token2 = peek()
            print(toPrettyPrint(token2))

            if token2.type == 'punctuation' and token2.value == "(" then
                -- this is a function call
                next() -- pop the peek()ed token
            else
                error("confused on current expression" .. toPrettyPrint(token1))
            end


            return expression
        end

        print("token: " .. toPrettyPrint(token))
        if token.type == "keyword" then
            if token.value == 'local' then
                local var_name = next()
                if (var_name.type ~= "keyword") then
                    error("expected a string to follow 'local'. got "  .. toPrettyPrint(var_name))
                end
                local operator = next()
                if (operator.type ~= 'operator' or operator.value ~= '=') then
                    error("expected an operator: ".. toPrettyPrint(operator))
                end

                expression = pop_expression();


                local statement = {
                    type = "statement",
                    isLocal = true,
                    variable = var_name.value,
                    operation = operator.value,
                    expression = expression,
                }
                print("STATEMENT: " .. toPrettyPrint(statement))
                -- TODO handle nested statements
                table.insert(block.contents, statement)

            else
                token_err()
            end
            
        else
            token_err()
        end
    end
    return block
end

local Lang = {}

function Lang:new(filepath)
    local lang = setmetatable({}, { __index = Lang })

    file = io.open(filepath, "r")

    lang.file = file
    lang.block = {}
  
    -- for c in file:lines() do
    --   print(c)
    -- end

    lang.block = generate_ast(file)

    return lang
end

function Lang:unroll()
    -- TODO
    -- TODO should probably be immutable, return a copy
    -- scan through the syntax tree for `require` and unroll them
    -- TODO optional skip certain requires?


end


-- when testing mlang on itself, this function is to test various edge cases
function edgeCases()
    local a, b

    a = 5; b = 
    2 a=3
end

return Lang
