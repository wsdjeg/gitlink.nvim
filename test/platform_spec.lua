-- test/platform_spec.lua
local lu = require('luaunit')

-- Require the module
local platform = require('gitlink.platform')

TestPlatform = {}

-- ============================================================
-- detect() - HTTP URLs
-- ============================================================

function TestPlatform:test_detect_github_http()
    lu.assertEquals(platform.detect('https://github.com/user/repo'), 'github')
    lu.assertEquals(platform.detect('http://github.com/user/repo'), 'github')
    lu.assertEquals(platform.detect('https://github.com/user/repo.git'), 'github')
end

function TestPlatform:test_detect_gitlab_http()
    lu.assertEquals(platform.detect('https://gitlab.com/user/repo'), 'gitlab')
end

function TestPlatform:test_detect_gitlab_custom_domain()
    lu.assertEquals(platform.detect('https://my.gitlab.com/user/repo'), 'gitlab')
    lu.assertEquals(platform.detect('https://gitlab.example.com/user/repo'), 'gitlab')
    lu.assertEquals(platform.detect('https://corp.gitlab.com/team/project'), 'gitlab')
end

function TestPlatform:test_detect_bitbucket_http()
    lu.assertEquals(platform.detect('https://bitbucket.org/user/repo'), 'bitbucket')
end

function TestPlatform:test_detect_gitee_http()
    lu.assertEquals(platform.detect('https://gitee.com/user/repo'), 'gitee')
end

function TestPlatform:test_detect_codeberg_http()
    lu.assertEquals(platform.detect('https://codeberg.org/user/repo'), 'codeberg')
end

function TestPlatform:test_detect_gitea_http()
    lu.assertEquals(platform.detect('https://gitea.com/user/repo'), 'gitea')
end

function TestPlatform:test_detect_gitea_custom_domain()
    lu.assertEquals(platform.detect('https://my.gitea.com/user/repo'), 'gitea')
    lu.assertEquals(platform.detect('https://gitea.example.com/user/repo'), 'gitea')
    lu.assertEquals(platform.detect('https://corp.gitea.com/team/project'), 'gitea')
end

function TestPlatform:test_detect_sourcehut_http()
    lu.assertEquals(platform.detect('https://git.sr.ht/~user/repo'), 'sourcehut')
end

function TestPlatform:test_detect_gitcode_http()
    lu.assertEquals(platform.detect('https://gitcode.com/user/repo'), 'gitcode')
end

-- ============================================================
-- detect() - SSH URLs (SCP-style: git@host:path)
-- ============================================================

function TestPlatform:test_detect_github_ssh()
    lu.assertEquals(platform.detect('git@github.com:user/repo.git'), 'github')
    lu.assertEquals(platform.detect('git@github.com:user/repo'), 'github')
end

function TestPlatform:test_detect_gitlab_ssh()
    lu.assertEquals(platform.detect('git@gitlab.com:user/repo.git'), 'gitlab')
    lu.assertEquals(platform.detect('git@gitlab.com:user/repo'), 'gitlab')
end

function TestPlatform:test_detect_gitlab_ssh_custom_domain()
    lu.assertEquals(platform.detect('git@my.gitlab.com:user/repo.git'), 'gitlab')
end

function TestPlatform:test_detect_bitbucket_ssh()
    lu.assertEquals(platform.detect('git@bitbucket.org:user/repo.git'), 'bitbucket')
end

function TestPlatform:test_detect_gitee_ssh()
    lu.assertEquals(platform.detect('git@gitee.com:user/repo.git'), 'gitee')
end

function TestPlatform:test_detect_codeberg_ssh()
    lu.assertEquals(platform.detect('git@codeberg.org:user/repo.git'), 'codeberg')
end

function TestPlatform:test_detect_gitea_ssh()
    lu.assertEquals(platform.detect('git@gitea.com:user/repo.git'), 'gitea')
end

function TestPlatform:test_detect_sourcehut_ssh()
    lu.assertEquals(platform.detect('git@git.sr.ht:~user/repo'), 'sourcehut')
end

function TestPlatform:test_detect_gitcode_ssh()
    lu.assertEquals(platform.detect('git@gitcode.com:user/repo.git'), 'gitcode')
end

-- ============================================================
-- detect() - SSH URLs (ssh:// protocol)
-- ============================================================

function TestPlatform:test_detect_github_ssh_protocol()
    lu.assertEquals(platform.detect('ssh://git@github.com/user/repo.git'), 'github')
    lu.assertEquals(platform.detect('ssh://github.com/user/repo.git'), 'github')
end

function TestPlatform:test_detect_gitlab_ssh_protocol()
    lu.assertEquals(platform.detect('ssh://git@gitlab.com/user/repo.git'), 'gitlab')
end

-- ============================================================
-- detect() - Edge cases
-- ============================================================

function TestPlatform:test_detect_nil_url()
    lu.assertEquals(platform.detect(nil), 'github')
end

function TestPlatform:test_detect_empty_url()
    lu.assertEquals(platform.detect(''), 'github')
end

function TestPlatform:test_detect_unknown_domain()
    lu.assertEquals(platform.detect('https://unknown.com/user/repo'), 'github')
    lu.assertEquals(platform.detect('https://example.org/user/repo'), 'github')
end

-- ============================================================
-- build_url() - Single line
-- ============================================================

function TestPlatform:test_build_url_github_single()
    local url = platform.build_url('github', 'https://github.com/user/repo', 'abc123', 'src/main.lua', 10)
    lu.assertEquals(url, 'https://github.com/user/repo/blob/abc123/src/main.lua#L10')
end

function TestPlatform:test_build_url_gitlab_single()
    local url = platform.build_url('gitlab', 'https://gitlab.com/user/repo', 'def456', 'lib/test.lua', 25)
    lu.assertEquals(url, 'https://gitlab.com/user/repo/-/blob/def456/lib/test.lua#L25')
end

function TestPlatform:test_build_url_bitbucket_single()
    local url = platform.build_url('bitbucket', 'https://bitbucket.org/user/repo', 'ghi789', 'app.js', 5)
    lu.assertEquals(url, 'https://bitbucket.org/user/repo/src/ghi789/app.js#lines-5')
end

function TestPlatform:test_build_url_gitee_single()
    local url = platform.build_url('gitee', 'https://gitee.com/user/repo', 'jkl012', 'index.html', 100)
    lu.assertEquals(url, 'https://gitee.com/user/repo/blob/jkl012/index.html#L100')
end

function TestPlatform:test_build_url_codeberg_single()
    local url = platform.build_url('codeberg', 'https://codeberg.org/user/repo', 'mno345', 'config.yml', 15)
    lu.assertEquals(url, 'https://codeberg.org/user/repo/src/commit/mno345/config.yml#L15')
end

function TestPlatform:test_build_url_gitea_single()
    local url = platform.build_url('gitea', 'https://gitea.com/user/repo', 'pqr678', 'main.go', 42)
    lu.assertEquals(url, 'https://gitea.com/user/repo/src/commit/pqr678/main.go#L42')
end

function TestPlatform:test_build_url_sourcehut_single()
    local url = platform.build_url('sourcehut', 'https://git.sr.ht/~user/repo', 'stu901', 'src/app.py', 7)
    lu.assertEquals(url, 'https://git.sr.ht/~user/repo/tree/stu901/item/src/app.py#L7')
end

function TestPlatform:test_build_url_gitcode_single()
    local url = platform.build_url('gitcode', 'https://gitcode.com/user/repo', 'vwx234', 'README.md', 1)
    lu.assertEquals(url, 'https://gitcode.com/user/repo/blob/vwx234/README.md#L1')
end

-- ============================================================
-- build_url() - Line range
-- ============================================================

function TestPlatform:test_build_url_github_range()
    local url = platform.build_url('github', 'https://github.com/user/repo', 'abc123', 'src/main.lua', 10, 20)
    lu.assertEquals(url, 'https://github.com/user/repo/blob/abc123/src/main.lua#L10-L20')
end

function TestPlatform:test_build_url_gitlab_range()
    local url = platform.build_url('gitlab', 'https://gitlab.com/user/repo', 'def456', 'lib/test.lua', 5, 15)
    lu.assertEquals(url, 'https://gitlab.com/user/repo/-/blob/def456/lib/test.lua#L5-15')
end

function TestPlatform:test_build_url_bitbucket_range()
    local url = platform.build_url('bitbucket', 'https://bitbucket.org/user/repo', 'ghi789', 'app.js', 1, 10)
    lu.assertEquals(url, 'https://bitbucket.org/user/repo/src/ghi789/app.js#lines-1:10')
end

function TestPlatform:test_build_url_gitee_range()
    local url = platform.build_url('gitee', 'https://gitee.com/user/repo', 'jkl012', 'index.html', 50, 100)
    lu.assertEquals(url, 'https://gitee.com/user/repo/blob/jkl012/index.html#L50-L100')
end

function TestPlatform:test_build_url_codeberg_range()
    local url = platform.build_url('codeberg', 'https://codeberg.org/user/repo', 'mno345', 'config.yml', 1, 5)
    lu.assertEquals(url, 'https://codeberg.org/user/repo/src/commit/mno345/config.yml#L1-L5')
end

function TestPlatform:test_build_url_gitea_range()
    local url = platform.build_url('gitea', 'https://gitea.com/user/repo', 'pqr678', 'main.go', 10, 30)
    lu.assertEquals(url, 'https://gitea.com/user/repo/src/commit/pqr678/main.go#L10-L30')
end

function TestPlatform:test_build_url_sourcehut_range()
    local url = platform.build_url('sourcehut', 'https://git.sr.ht/~user/repo', 'stu901', 'src/app.py', 3, 9)
    lu.assertEquals(url, 'https://git.sr.ht/~user/repo/tree/stu901/item/src/app.py#L3-L9')
end

function TestPlatform:test_build_url_gitcode_range()
    local url = platform.build_url('gitcode', 'https://gitcode.com/user/repo', 'vwx234', 'README.md', 1, 10)
    lu.assertEquals(url, 'https://gitcode.com/user/repo/blob/vwx234/README.md#L1-L10')
end

-- ============================================================
-- build_url() - Edge cases
-- ============================================================

function TestPlatform:test_build_url_unknown_platform_fallback()
    local url = platform.build_url('unknown', 'https://unknown.com/user/repo', 'pqr678', 'file.txt', 1)
    lu.assertEquals(url, 'https://unknown.com/user/repo/blob/pqr678/file.txt#L1')
end

function TestPlatform:test_build_url_same_start_end_no_range()
    -- line_end == line_start should produce single-line URL
    local url = platform.build_url('github', 'https://github.com/user/repo', 'abc123', 'main.lua', 10, 10)
    lu.assertEquals(url, 'https://github.com/user/repo/blob/abc123/main.lua#L10')
end

function TestPlatform:test_build_url_nested_path()
    local url = platform.build_url('github', 'https://github.com/user/repo', 'abc123', 'src/deep/nested/file.lua', 5)
    lu.assertEquals(url, 'https://github.com/user/repo/blob/abc123/src/deep/nested/file.lua#L5')
end

function TestPlatform:test_build_url_line_1()
    local url = platform.build_url('github', 'https://github.com/user/repo', 'abc123', 'main.lua', 1)
    lu.assertEquals(url, 'https://github.com/user/repo/blob/abc123/main.lua#L1')
end

-- ============================================================
-- get_platforms()
-- ============================================================

function TestPlatform:test_get_platforms()
    local platforms = platform.get_platforms()
    lu.assertEquals(#platforms, 8)
    table.sort(platforms)
    lu.assertEquals(platforms[1], 'bitbucket')
    lu.assertEquals(platforms[2], 'codeberg')
    lu.assertEquals(platforms[3], 'gitcode')
    lu.assertEquals(platforms[4], 'gitea')
    lu.assertEquals(platforms[5], 'gitee')
    lu.assertEquals(platforms[6], 'github')
    lu.assertEquals(platforms[7], 'gitlab')
    lu.assertEquals(platforms[8], 'sourcehut')
end

-- ============================================================
-- get_platform_info()
-- ============================================================

function TestPlatform:test_get_platform_info_github()
    local info = platform.get_platform_info('github')
    lu.assertEquals(info.name, 'github')
    lu.assertEquals(info.domains, { 'github.com' })
    lu.assertFalse(info.has_custom_detector)
end

function TestPlatform:test_get_platform_info_gitlab()
    local info = platform.get_platform_info('gitlab')
    lu.assertEquals(info.name, 'gitlab')
    lu.assertEquals(info.domains, { 'gitlab.com' })
    lu.assertTrue(info.has_custom_detector)
end

function TestPlatform:test_get_platform_info_gitea()
    local info = platform.get_platform_info('gitea')
    lu.assertEquals(info.name, 'gitea')
    lu.assertEquals(info.domains, { 'gitea.com' })
    lu.assertTrue(info.has_custom_detector)
end

function TestPlatform:test_get_platform_info_sourcehut()
    local info = platform.get_platform_info('sourcehut')
    lu.assertEquals(info.name, 'sourcehut')
    lu.assertEquals(info.domains, { 'git.sr.ht' })
    lu.assertFalse(info.has_custom_detector)
end

function TestPlatform:test_get_platform_info_unknown()
    lu.assertNil(platform.get_platform_info('nonexistent'))
end

