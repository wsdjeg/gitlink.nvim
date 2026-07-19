-- test/init_spec.lua
local lu = require('luaunit')

-- Require the module
local gitlink = require('gitlink')

TestInit = {}

-- ============================================================
-- remote_url_to_http() - SCP-style SSH URLs (git@host:path)
-- ============================================================

function TestInit:test_ssh_github_with_git_suffix()
    local url = gitlink.remote_url_to_http('git@github.com:user/repo.git')
    lu.assertEquals(url, 'https://github.com/user/repo')
end

function TestInit:test_ssh_github_without_git_suffix()
    local url = gitlink.remote_url_to_http('git@github.com:user/repo')
    lu.assertEquals(url, 'https://github.com/user/repo')
end

function TestInit:test_ssh_gitlab_with_git_suffix()
    local url = gitlink.remote_url_to_http('git@gitlab.com:user/repo.git')
    lu.assertEquals(url, 'https://gitlab.com/user/repo')
end

function TestInit:test_ssh_gitlab_without_git_suffix()
    local url = gitlink.remote_url_to_http('git@gitlab.com:user/repo')
    lu.assertEquals(url, 'https://gitlab.com/user/repo')
end

function TestInit:test_ssh_custom_domain_with_git_suffix()
    local url = gitlink.remote_url_to_http('git@my.gitlab.com:team/project.git')
    lu.assertEquals(url, 'https://my.gitlab.com/team/project')
end

function TestInit:test_ssh_custom_domain_without_git_suffix()
    local url = gitlink.remote_url_to_http('git@gitea.example.com:user/repo')
    lu.assertEquals(url, 'https://gitea.example.com/user/repo')
end

function TestInit:test_ssh_bitbucket()
    local url = gitlink.remote_url_to_http('git@bitbucket.org:user/repo.git')
    lu.assertEquals(url, 'https://bitbucket.org/user/repo')
end

function TestInit:test_ssh_sourcehut()
    local url = gitlink.remote_url_to_http('git@git.sr.ht:~user/repo')
    lu.assertEquals(url, 'https://git.sr.ht/~user/repo')
end

function TestInit:test_ssh_nested_path()
    local url = gitlink.remote_url_to_http('git@github.com:org/sub/repo.git')
    lu.assertEquals(url, 'https://github.com/org/sub/repo')
end

-- ============================================================
-- remote_url_to_http() - ssh:// protocol URLs
-- ============================================================

function TestInit:test_ssh_protocol_with_user()
    local url = gitlink.remote_url_to_http('ssh://git@github.com/user/repo.git')
    lu.assertEquals(url, 'https://github.com/user/repo')
end

function TestInit:test_ssh_protocol_without_user()
    local url = gitlink.remote_url_to_http('ssh://github.com/user/repo.git')
    lu.assertEquals(url, 'https://github.com/user/repo')
end

function TestInit:test_ssh_protocol_without_git_suffix()
    local url = gitlink.remote_url_to_http('ssh://git@gitlab.com/user/repo')
    lu.assertEquals(url, 'https://gitlab.com/user/repo')
end

function TestInit:test_ssh_protocol_custom_domain()
    local url = gitlink.remote_url_to_http('ssh://git@gitea.example.com/team/project.git')
    lu.assertEquals(url, 'https://gitea.example.com/team/project')
end

-- ============================================================
-- remote_url_to_http() - HTTP(S) URLs
-- ============================================================

function TestInit:test_https_with_git_suffix()
    local url = gitlink.remote_url_to_http('https://github.com/user/repo.git')
    lu.assertEquals(url, 'https://github.com/user/repo')
end

function TestInit:test_https_without_git_suffix()
    local url = gitlink.remote_url_to_http('https://github.com/user/repo')
    lu.assertEquals(url, 'https://github.com/user/repo')
end

function TestInit:test_http_with_git_suffix()
    local url = gitlink.remote_url_to_http('http://github.com/user/repo.git')
    lu.assertEquals(url, 'http://github.com/user/repo')
end

function TestInit:test_https_gitlab_with_git_suffix()
    local url = gitlink.remote_url_to_http('https://gitlab.com/user/repo.git')
    lu.assertEquals(url, 'https://gitlab.com/user/repo')
end

function TestInit:test_https_custom_domain()
    local url = gitlink.remote_url_to_http('https://my.gitea.com/user/repo.git')
    lu.assertEquals(url, 'https://my.gitea.com/user/repo')
end

function TestInit:test_https_nested_path()
    local url = gitlink.remote_url_to_http('https://github.com/org/sub/repo.git')
    lu.assertEquals(url, 'https://github.com/org/sub/repo')
end

function TestInit:test_https_sourcehut()
    local url = gitlink.remote_url_to_http('https://git.sr.ht/~user/repo.git')
    lu.assertEquals(url, 'https://git.sr.ht/~user/repo')
end

-- ============================================================
-- remote_url_to_http() - Edge cases
-- ============================================================

function TestInit:test_empty_string()
    local url = gitlink.remote_url_to_http('')
    lu.assertEquals(url, '')
end

function TestInit:test_plain_url_no_protocol()
    local url = gitlink.remote_url_to_http('github.com/user/repo')
    lu.assertEquals(url, 'github.com/user/repo')
end

