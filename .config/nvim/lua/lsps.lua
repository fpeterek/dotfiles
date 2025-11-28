lsp_on_attach = function(client, bufnr)
    lsp_buf_keybindings(bufnr)

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr })
    end

end


vim.lsp.config('clangd', {
    cmd = { 'clangd', '--clang-tidy' },

    init_options = {
        InlayHints = {
            Designators = true,
            Enabled = true,
            ParameterNames = true,
            DeducedTypes = true,
        },
        fallbackFlags = { "-std=c++23", "-Wall", "-Wextra", "-Wconversion" },
    },

    on_attach = lsp_on_attach,
})

vim.lsp.enable('clangd')


vim.lsp.config('rust_analyzer', {
    settings = {
        ["rust-analyzer"] = {
              inlayHints = {
                  bindingModeHints = {
                      enable = false,
                  },
                  chainingHints = {
                      enable = true,
                  },
                  closingBraceHints = {
                      enable = true,
                      minLines = 25,
                  },
                  closureReturnTypeHints = {
                      enable = "never",
                  },
                  lifetimeElisionHints = {
                      enable = "never",
                      useParameterNames = false,
                  },
                  maxLength = 25,
                  parameterHints = {
                      enable = true,
                  },
                  reborrowHints = {
                      enable = "never",
                  },
                  renderColons = true,
                  typeHints = {
                      enable = true,
                      hideClosureInitialization = false,
                      hideNamedConstructor = false,
                  },
            },
        }
    },

    on_attach = lsp_on_attach,
})

vim.lsp.enable('rust_analyzer')


vim.lsp.config('pylsp', {
    settings = {
        pylsp = {
            plugins = {
                autopep8 = { enabled = false },
                black = { enabled = true },
                yapf = { enabled = false, },

                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                pylint = { enabled = false },
                mccabe = { enabled = false },
                preload = { enabled = false },

                jedi_completion = { fuzzy = true },

                flake8 = {
                    enabled = true,
                    ignore = { 'E501', 'C901' },
                    maxLineLength = 100,
                },

            },
            configurationSources = { 'flake8' },
        }
    },

    on_attach = lsp_on_attach,
})

vim.lsp.enable('pylsp')


vim.lsp.config('kotlin_language_server', {
    on_attach = lsp_on_attach,
})

vim.lsp.enable('kotlin_language_server')


vim.lsp.config('hls', {
    on_attach = lsp_on_attach,
})

vim.lsp.enable('hls')
