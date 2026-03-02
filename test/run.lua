-- test/run.lua
-- Test runner for headless Neovim

local lu = require('luaunit')

-- Add test directory to runtime path
vim.opt.runtimepath:append('.')

-- Load test files
local test_files = {
    'test/platform_spec.lua',
}

-- Run all tests
local function run_tests()
    local runner = lu.LuaUnit:new()
    runner:setOutputType('text')
    
    local results = {}
    local failed = 0
    
    for _, test_file in ipairs(test_files) do
        print(string.format('\n=== Running %s ===', test_file))
        local ok, err = pcall(dofile, test_file)
        if not ok then
            print(string.format('Error loading %s: %s', test_file, err))
            failed = failed + 1
        end
    end
    
    return failed
end

local failed = run_tests()
vim.cmd('qa!')
os.exit(failed > 0 and 1 or 0)

