--""""""""""""""""""""""   Language Server Configs   """"""""""""""""""""""""""

vim.cmd("packadd nvim-lsp")
local nvim_lsp = require 'nvim_lsp'
local nvim_util = require 'nvim_lsp/util'
local home = vim.loop.os_homedir()
local dir = "/programs/lua-language-server"

local function bundle()
end

--[[                         CCLS                                ]]

nvim_lsp.ccls.setup{
	cmd = { home .. "/programs/ccls/Release/ccls", "-log-file=/tmp/ccls.log -v=1" };
	on_attach = bundle();
	root_dir = nvim_util.root_pattern("compile_commands.json");
}

--[[                         LUA_SUMNEKO                         ]]

nvim_lsp.sumneko_lua.setup{
	cmd = { home .. dir .. "/bin/Linux/lua-language-server", "-E", home .. dir .. "/main.lua" };
	on_attach = bundle();
	settings = {
		Lua = {
			runtime = {
				version = "Lua 5.1"
			};
			workspace = {
				ignoreSubmodules = "false";
				ignoreDir = { ".git", "build" }
			}
		}
	};
}
--"Lua.runtime.version" = { "Lua 5.1" },
--Lua.workspace.ignoreDir = { ".git", "build" },

--[[                         CCLS                                ]]

dir = "/runenv/vim/kotlin-language-server/server/build/install/server/bin/"
nvim_lsp.kotlin_language_server.setup {
	cmd = { home .. dir .. "kotlin-language-server" };
	on_attach = bundle();
}

-- nvim expects anything but nil
return {}
