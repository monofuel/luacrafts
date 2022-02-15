-- TODO figure out stuff on relative imports
local Lang = require('mlang/mlang')

-- possible features:
--  detect import cycles?
--  flatten / bundle requires?
--  linting
--  formatting
--  minify / obfuscate?

testSuite("mlang", function()
    skipTest("mlang parse self", function()
        lang = Lang:new('mlang/mlang.lua')
    end)
end)