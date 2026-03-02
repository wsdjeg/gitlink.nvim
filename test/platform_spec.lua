-- test/platform_spec.lua
local lu = require('luaunit')

-- Require the module
local platform = require('gitlink.platform')

TestPlatform = {}

function TestPlatform:test_detect_github()
    lu.assertEquals(platform.detect('https://github.com/user/repo'), 'github')
    lu.assertEquals(platform.detect('https://git.githubusercontent.com/user/repo'), 'github')
end

function TestPlatform:test_detect_gitlab()
    lu.assertEquals(platform.detect('https://gitlab.com/user/repo'), 'gitlab')
    lu.assertEquals(platform.detect('https://my.gitlab.com/user/repo'), 'gitlab')
end

function TestPlatform:test_detect_bitbucket()
    lu.assertEquals(platform.detect('https://bitbucket.org/user/repo'), 'bitbucket')
end

function TestPlatform:test_detect_gitee()
    lu.assertEquals(platform.detect('https://gitee.com/user/repo'), 'gitee')
end

function TestPlatform:test_detect_codeberg()
    lu.assertEquals(platform.detect('https://codeberg.org/user/repo'), 'codeberg')
end

function TestPlatform:test_detect_nil_url()
    lu.assertEquals(platform.detect(nil), 'github')
end

function TestPlatform:test_detect_unknown_domain()
    lu.assertEquals(platform.detect('https://unknown.com/user/repo'), 'github')
end

function TestPlatform:test_build_url_github()
    local url =
        platform.build_url('github', 'https://github.com/user/repo', 'abc123', 'src/main.lua', 10)
    lu.assertEquals(url, 'https://github.com/user/repo/blob/abc123/src/main.lua#L10')
end

function TestPlatform:test_build_url_gitlab()
    local url =
        platform.build_url('gitlab', 'https://gitlab.com/user/repo', 'def456', 'lib/test.lua', 25)
    lu.assertEquals(url, 'https://gitlab.com/user/repo/-/blob/def456/lib/test.lua#L25')
end

function TestPlatform:test_build_url_bitbucket()
    local url =
        platform.build_url('bitbucket', 'https://bitbucket.org/user/repo', 'ghi789', 'app.js', 5)
    lu.assertEquals(url, 'https://bitbucket.org/user/repo/src/ghi789/app.js#lines-5')
end

function TestPlatform:test_build_url_gitee()
    local url =
        platform.build_url('gitee', 'https://gitee.com/user/repo', 'jkl012', 'index.html', 100)
    lu.assertEquals(url, 'https://gitee.com/user/repo/blob/jkl012/index.html#L100')
end

function TestPlatform:test_build_url_codeberg()
    local url =
        platform.build_url('codeberg', 'https://codeberg.org/user/repo', 'mno345', 'config.yml', 15)
    lu.assertEquals(url, 'https://codeberg.org/user/repo/src/commit/mno345/config.yml#L15')
end

function TestPlatform:test_build_url_unknown_platform()
    local url =
        platform.build_url('unknown', 'https://unknown.com/user/repo', 'pqr678', 'file.txt', 1)
    lu.assertEquals(url, 'https://unknown.com/user/repo/blob/pqr678/file.txt#L1')
end

function TestPlatform:test_get_platforms()
    local platforms = platform.get_platforms()
    lu.assertEquals(#platforms, 5)
    table.sort(platforms)
    lu.assertEquals(platforms[1], 'bitbucket')
    lu.assertEquals(platforms[2], 'codeberg')
    lu.assertEquals(platforms[3], 'gitee')
    lu.assertEquals(platforms[4], 'github')
    lu.assertEquals(platforms[5], 'gitlab')
end

-- Run tests
local runner = lu.LuaUnit:new()
runner:setOutputType('text')
os.exit(runner:runSuite())
