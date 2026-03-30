return {
  urls = {
    'https://github.com/folke/lazydev.nvim',
    'https://github.com/Bilal2453/luvit-meta',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/williamboman/mason-lspconfig.nvim',
    'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
    'https://github.com/j-hui/fidget.nvim',
  },

  config = function()
    require('lazydev').setup({
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    })

    require('fidget').setup({})

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        local fzf = require('fzf-lua')

        map("gd", fzf.lsp_definitions, "Definitions")
        map("gr", fzf.lsp_references, "References")
        map("gI", fzf.lsp_implementations, "Implementation")
        map("<leader>D", fzf.lsp_typedefs, "Type Definition")
        map("<leader>ds", fzf.lsp_document_symbols, "Document Symbols")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup =
              vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    local servers = {
      cspell = {},
      vtsls = {
        settings = {
          typescript = {
            preferences = {
              importModuleSpecifier = project_name == "v2" and "relative" or nil,
              importModuleSpecifierEnding = "minimal",
            },
          },
        }
      },
      eslint = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    }

    require("mason").setup()
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua",
    })
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })

    -- Setup cspell manually (not in lspconfig by default)
    if servers.cspell then
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

      if not configs.cspell then
        local node_path = vim.fn.exepath("node")
        local cspell_lsp_path = vim.fn.exepath("cspell-lsp")
        
        configs.cspell = {
          default_config = {
            cmd = { node_path, cspell_lsp_path, "--stdio" },
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "python",
              "lua",
              "json",
              "markdown",
              "text",
            },
            root_dir = lspconfig.util.root_pattern("cspell.json", ".cspell.json", "package.json", ".git"),
            single_file_support = true,
            settings = {
              cspell = {
                config = vim.fn.expand("~/.config/nvim-pack/cspell.json"),
              },
            },
          },
        }
      end

      lspconfig.cspell.setup({
        capabilities = capabilities,
      })
    end
  end,
}
