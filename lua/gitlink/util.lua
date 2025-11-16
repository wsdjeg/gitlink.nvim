local M = {}

local nt
local log

function M.notify(msg, color)
    if not nt then
        pcall(function()
            nt = require('notify')
        end)
    end
    if not nt then
        vim.api.nvim_echo({ { msg } }, false, {})
        return
    end
    nt.notify(msg, color)
end

function M.info(msg)
    if not log then
        pcall(function()
            log = require('logger').derive('gitlink')
        end)
    end
    if not log then
        return
    end
    log.info(msg)
end
function M.debug(msg)
    if not log then
        pcall(function()
            log = require('logger').derive('gitlink')
        end)
    end
    if not log then
        return
    end
    log.debug(msg)
end

return M
