-- TODO figure out stuff on relative imports
local Lang = require('mlang/mlang')

-- possible features:
--  detect import cycles?
--  flatten / bundle requires?
--  linting
--  formatting
--  minify / obfuscate?

function main()
    -- test mlang on itself
    lang = Lang:new('mlang/mlang.lua')
end

-- TODO re-enable this test
-- main()