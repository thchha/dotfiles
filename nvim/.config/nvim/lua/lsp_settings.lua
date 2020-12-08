vim.cmd("packadd nvim-lsp")
local nvim_lsp = require 'nvim_lsp'
local nvim_util = require 'nvim_lsp/util'
local home = vim.loop.os_homedir()
local dir = "/programs/lua-language-server"
local diag = vim.lsp.diagnostic

nvim_lsp.clangd.setup{}

local configs = require 'nvim_lsp/configs'

configs.perl = {
  default_config = {
    cmd = {'perl', '-MPerl::LanguageServer', '-e', 'Perl::LanguageServer::run', '--', '--debug', '--log-level', '10' };
    filetypes = { "perl" };
    root_dir = vim.loop.cwd;
  }
}

nvim_lsp.perl.setup {};

nvim_lsp.sumneko_lua.setup{
  on_attach = function(...)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = false,
      virtual_text = {spacing = 10},
      signs = false,
      update_in_insert = true,
    })
  end;
	cmd = { home .. dir .. "/bin/Linux/lua-language-server", "-E", home .. dir .. "/main.lua" };
	settings = {
		Lua = {
      diagnostics = {
        globals = {'vim'},
      },
			runtime = {
				version = "Lua 5.1"
			};
			workspace = {
        library = {[vim.fn.expand("$VIMRUNTIME/lua")] = true };
				ignoreSubmodules = "false";
				ignoreDir = { ".git", "build" }
			}
		}
	};
}
--"Lua.runtime.version" = { "Lua 5.1" },
--Lua.workspace.ignoreDir = { ".git", "build" },

-- TODO: disable underlining
local function onAttach()
  local function texlab_build()
    local curBuf = vim.fn.bufnr()
    local params = {
      textDocument = vim.lsp.util.make_text_document_params()
    }
    local _, cancellation_obj = vim.lsp.buf_request(curBuf, 'textDocument/build', params, function(...)
      print("returning from build..", ..., "type:", type(...))
      vim.fn.cancellation_obj = nil
    end)
    vim.fn.cancellation_obj = cancellation_obj
  end
  local function texlab_build_cancel()
    if vim.fn.cancellation_obj then
      vim.fn.cancellation_obj()
      vim.fn.cancellation_obj = nil
    end
  end
  local function texlab_forward_search()
    local curBuf = vim.fn.bufnr()
    vim.lsp.buf_request(curBuf, 'textDocument/forwardSearch', vim.lsp.util.make_position_params(), function(...)
      print("result", ...)
      for k,v in pairs(select(3, ...)) do
        print("kv:", k, v)
      end
    end)
  end

  vim.fn.texlab_build = texlab_build;
  vim.fn.texlab_build_cancel = texlab_build_cancel;
  vim.fn.texlab_forward_search = texlab_forward_search;
end

nvim_lsp.kotlin_language_server.setup {
	cmd = { home ..  "/runenv/kotlin-language-server/server/build/install/server/bin/kotlin-language-server" };
}

nvim_lsp.texlab.setup {
  on_attach = onAttach;
  cmd = { home .. "/programs/texlab/target/release/texlab" };
  cmd_env = { RUST_BACKTRACE=1 };
  filetypes = { "tex", "plaintex", "latex" };
  root_dir = vim.loop.cwd;
  settings = {
    latex = {
      rootDirectory = vim.loop.cwd();
      build = {
        args = {"-interaction=nonstopmode", "-outdir=" .. vim.loop.cwd() .. "/out", "-pdf", "-pvc", "-synctex=1", "-f", "%f"};
        onSave = true;
        outputDirectory = vim.loop.cwd() .. "/out";
      },
      forwardSearch = {
        executable = "okular",
        args = {"--unique", "file:%p#src:%l%f"},
      },
    };
    bibtex = {
      formatting = {
        lineLength = 120
      };
    };
  };
}

nvim_lsp.zamba.setup {
  cmd = { "/home/tomes/runenv/gambit/current/bin/gsi", "/home/tomes/workspace/zamba-ls/zamba.scm" };
  settings = {
    gambitSrcDir = home .. "/workspace/gambit/lib/";
  };
}

--[[

nvim_lsp.ccls.setup{
	cmd = { home .. "/programs/ccls/Release/ccls", "-log-file=/tmp/ccls.log -v=1" };
	on_attach = bundle();
	root_dir = nvim_util.root_pattern("compile_commands.json");
}

]]
-- nvim expects anything but nil
return {}
