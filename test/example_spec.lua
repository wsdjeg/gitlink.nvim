-- test/example_spec.lua
-- Example test file demonstrating the test structure

local lu = require('luaunit')

local gitlink = require('gitlink')

TestExample = {}

function TestExample:test_module_exists()
    lu.assertNotNil(gitlink)
end

function TestExample:test_setup_function_exists()
    lu.assertEquals(type(gitlink.setup), 'function')
end

function TestExample:test_open_function_exists()
    lu.assertEquals(type(gitlink.open), 'function')
end

function TestExample:test_copy_function_exists()
    lu.assertEquals(type(gitlink.copy), 'function')
end

