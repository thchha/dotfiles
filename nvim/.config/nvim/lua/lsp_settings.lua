--""""""""""""""""""""""   Language Server Configs   """"""""""""""""""""""""""

vim.cmd("packadd nvim-lsp")
local nvim_lsp = require 'nvim_lsp'
local nvim_util = require 'nvim_lsp/util'
local oldPath = package.path
local home = vim.loop.os_homedir()
package.path = home .. '/.local/share/nvim/site/pack/git-plugins/start/diagnostic-nvim/lua/?.lua;'
package.path = package.path .. home ..'/.local/share/nvim/site/pack/git-plugins/start/completion-nvim/lua/?.lua'
local completion = require 'completion'
local diag = require 'diagnostic'
package.path = oldPath
nvim_lsp.ccls.setup{
	cmd = { home .. "/programs/ccls/Release/ccls", "-log-file=/tmp/ccls.log -v=1" };
	on_attach = function()
		completion.on_attach()
		diag.on_attach()
	end;
	root_dir = nvim_util.root_pattern("compile_commands.json");
}
local dir = "/programs/lua-language-server"
nvim_lsp.sumneko_lua.setup{
	cmd = { home .. dir .. "/bin/Linux/lua-language-server", "-E", home .. dir .. "/main.lua" };
	on_attach = function()
		completion.on_attach()
		diag.on_attach()
	end;
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

return {}
