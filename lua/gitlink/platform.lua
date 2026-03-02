local M = {}

-- Platform definitions with their URL patterns
local platforms = {
    github = {
        domains = { 'github.com', 'git.githubusercontent.com' },
        url_format = function(base_url, commit, path, line)
            return string.format('%s/blob/%s/%s#L%d', base_url, commit, path, line)
        end,
    },
    gitlab = {
        domains = { 'gitlab.com' },
        url_format = function(base_url, commit, path, line)
            return string.format('%s/-/blob/%s/%s#L%d', base_url, commit, path, line)
        end,
        custom_detector = function(url)
            -- Detect custom GitLab instances
            local patterns = { 'gitlab%.', '%.gitlab%.com' }
            for _, pattern in ipairs(patterns) do
                if url:match(pattern) then
                    return true
                end
            end
            return false
        end,
    },
    bitbucket = {
        domains = { 'bitbucket.org' },
        url_format = function(base_url, commit, path, line)
            return string.format('%s/src/%s/%s#lines-%d', base_url, commit, path, line)
        end,
    },
    gitee = {
        domains = { 'gitee.com' },
        url_format = function(base_url, commit, path, line)
            return string.format('%s/blob/%s/%s#L%d', base_url, commit, path, line)
        end,
    },
    codeberg = {
        domains = { 'codeberg.org' },
        url_format = function(base_url, commit, path, line)
            return string.format('%s/src/commit/%s/%s#L%d', base_url, commit, path, line)
        end,
    },
}

-- Detect platform from URL
function M.detect(url)
    if not url then
        return 'github' -- default to GitHub
    end
    
    -- Extract domain from URL
    local domain = url:match('https?://([^/]+)') or ''
    
    -- Check each platform
    for platform_name, platform_config in pairs(platforms) do
        -- Check domain list
        for _, platform_domain in ipairs(platform_config.domains) do
            if domain:find(platform_domain, 1, true) then
                return platform_name
            end
        end
        
        -- Check custom detector
        if platform_config.custom_detector then
            if platform_config.custom_detector(url) then
                return platform_name
            end
        end
    end
    
    -- Default to GitHub
    return 'github'
end

-- Build URL for specific platform
function M.build_url(platform_name, base_url, commit, path, line)
    local platform = platforms[platform_name]
    if not platform then
        platform = platforms.github
    end
    
    return platform.url_format(base_url, commit, path, line)
end

-- Get all supported platforms
function M.get_platforms()
    return vim.tbl_keys(platforms)
end

return M

